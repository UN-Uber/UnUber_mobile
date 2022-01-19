// Package imports:
import 'package:stacked_services/stacked_services.dart';

// Project imports:
import 'package:unuber_mobile/app/app.locator.dart';
import 'package:unuber_mobile/models/server_response_model.dart';
import 'package:unuber_mobile/services/api/errors/api_errors.dart';
import 'package:unuber_mobile/services/api/qraphql/mutations/user/update_user.dart';
import 'package:unuber_mobile/services/api/qraphql/queries/user_info/get_user_by_id.dart';
import 'package:unuber_mobile/services/secure_storage/secure_storage_service.dart';

/// Is the service used to manage the graphql queries and mutations for the user info
class UserCRUDService {
  /// Is the service used to store encrypted data
  final _secureStorageService = locator<SecureStorageService>();

  /// Is the name of the user logged in the app
  String userName = "";

  /// Is the email of the user logged in the app
  String email = "";

  /// The method getUserInfo is used to query the api gateway for the user id info stored in the auth token
  /// - return a ServerResponseModel from the api gateway
  Future<ServerResponseModel> getUserInfo() async {
    late ServerResponseModel response;

    try {
      // Get auth token and user id
      String? token = await _secureStorageService.getValue(key: 'authToken');
      int? id =
          int.parse(await _secureStorageService.getValue(key: 'userId') ?? );

      if (token != null) {
        // token exists
        response = await getUserById(id: id, token: token);
      }
    } catch (excep) {
      response = errorResponse(excep);
    }

    return response;
  }

  /// The method setMinInfo is used to query jsut the name and email from the user for the drawer in home view
  Future setMinInfo() async {
    final response = await getUserInfo();

    if (response.data != null) {
      // Succesfull query to the api gateway
      this.userName =
          '${response.data['getClient']['fName']} ${response.data['getClient']['sureName']}';
      this.email = response.data['getClient']['email'];
    } else {
      // Error in query
      this.userName = 'Bienvenido Usuario!';
      this.email = 'something@something.com';
    }
  }

  Future<ServerResponseModel> updateUserInfo(
      {required String firstName,
      String? secondName,
      required String surename,
      required int active,
      required String email,
      required String telephone}) async {
    late ServerResponseModel response;

    try {
      // Get auth token and user id
      String? token = await _secureStorageService.getValue(key: 'authToken');
      int? id =
          int.parse(await _secureStorageService.getValue(key: 'userId') ?? );

      if (token != null) {
        // token exists
        response = await updateUser(token,
            idClient: id,
            firstName: firstName,
            surename: surename,
            active: active,
            email: email,
            telephone: telephone);
      }
    } catch (excep) {
      response = errorResponse(excep);
    }

    return response;
  }
}
