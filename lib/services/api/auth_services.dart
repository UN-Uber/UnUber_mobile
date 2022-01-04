// Project imports:
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unuber_mobile/app/app.locator.dart';
import 'package:unuber_mobile/models/server_response_model.dart';
import 'package:unuber_mobile/services/api/errors/api_errors.dart';
import 'package:unuber_mobile/services/api/qraphql/queries/auth/token_getter.dart';
import 'package:unuber_mobile/services/validations/login_validation_service.dart';

/// The class AuthService is the service that manage the authorization inthe API gateway
class AuthService {
  /// The method getToken is used to obtain an authorization token from the API Gateway
  Future<ServerResponseModel> getToken(
      {String? email, String? telephone, required String password}) async {
    /// Is the service for login validation
    final _loginValidationService = locator<LoginValidationService>();

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
    } catch (excep) {
      response = errorResponse(excep);
    }

    return response;
  }

  /// The method _setAccessToken is used to persist the access token
  /// - @Param token is the access token to be stored
  _setAccessToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('authToken', token);
  }
}
