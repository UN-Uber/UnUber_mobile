// Package imports:
import 'package:jwt_decoder/jwt_decoder.dart';

// Project imports:
import 'package:unuber_mobile/app/app.locator.dart';
import 'package:unuber_mobile/models/server_response_model.dart';
import 'package:unuber_mobile/services/api/errors/api_errors.dart';
import 'package:unuber_mobile/services/api/qraphql/mutations/auth/user_signup.dart';
import 'package:unuber_mobile/services/api/qraphql/queries/auth/token_getter.dart';
import 'package:unuber_mobile/services/secure_storage/secure_storage_service.dart';
import 'package:unuber_mobile/services/validations/login_validation_service.dart';

/// The class AuthService is the service that manage the authorization inthe API gateway
class AuthService {
  /// Is the service for login validation
  final LoginValidationService _loginValidationService =
      locator<LoginValidationService>();

  /// Is the service for secure storage
  final SecureStorageService _secureStorageService =
      locator<SecureStorageService>();

  /// The method getToken is used to obtain an authorization token from the API Gateway
  Future<ServerResponseModel> getToken(
      {String? email, String? telephone, required String password}) async {
    /// Response from the server
    ServerResponseModel response;

    try {
      _loginValidationService.isTelephone
          ? response = await tokenGetter(
              email: null, telephone: telephone, password: password)
          : response = await tokenGetter(
              email: email, telephone: null, password: password);
      if (!response.hasError && response.exception == null)
        // Persist the access token for next app start
        await _setAccessToken(response.data['login']['token'] as String);
        
        // Persiste the id of the authenticated user for use queries and mutatuions
        // that require it
        await _setAuthenticatedUserId(response.data['login']['token'] as String);
    } catch (excep) {
      response = errorResponse(excep);
    }

    return response;
  }

  Future<ServerResponseModel> signupNewUser(
      {required String firstName,
      String? secondName,
      required String surename,
      required String email,
      required String telephone,
      required String password}) async {
    ServerResponseModel response;

    try {
      response = await userSignup(
          firstName: firstName,
          surename: surename,
          active: 1,
          email: email,
          telephone: telephone,
          image: 'No image',
          password: password);
    } catch (excep) {
      response = errorResponse(excep);
    }

    return response;
  }

  /// The method _setAccessToken is used to persist the access token
  /// - @Param token is the access token to be stored
  _setAccessToken(String token) async {
    await _secureStorageService.store(key: 'authToken', value: token);
    print('token in AuthService => ${await _secureStorageService.getValue(key: 'authToken')}');
  }

  /// The method _setAuthenticatedUserId is used to persist the id of the
  /// authenticated user from the extrated information from token
  /// - @Param token is the access token to be decode
  _setAuthenticatedUserId(String token) async {
    Map<String, dynamic> tokenInfo = JwtDecoder.decode(token);
    String id = tokenInfo['id'].toString();
    await _secureStorageService.store(key: 'userId', value: id);
  }
}
