// Package imports:
import 'package:stacked_services/stacked_services.dart';

// Project imports:
import 'package:unuber_mobile/app/app.locator.dart';
import 'package:unuber_mobile/models/server_response_model.dart';
import 'package:unuber_mobile/services/api/errors/api_errors.dart';
import 'package:unuber_mobile/services/api/qraphql/queries/user_info/get_user_by_id.dart';
import 'package:unuber_mobile/services/secure_storage/secure_storage_service.dart';

/// Is the service used to manage the graphql queries and mutations for the user info
class UserCRUDService {
  /// Is the service used to store encrypted data
  final _secureStorageService = locator<SecureStorageService>();

  /// Is the name of the user logged in the app
  String? _userName;
  /// Is the email of the user logged in the app
  String? _email;

  // Getters
  String? get userName => this._userName;
  String? get email => this._email;

  UserCRUDService(){
    setMinInfo();
  }

  /// The method getUserInfo is used to query the api gateway for the user id info stored in the auth token
  /// - return a ServerResponseModel from the api gateway
  Future<ServerResponseModel> getUserInfo() async {
    late ServerResponseModel response;

    try{
      // Get auth token and user id
      String? token = await _secureStorageService.getStringValue(key: 'authToken');
      int? id = await _secureStorageService.getIntValue(key: 'userId');

      if (token != null && id != null){
        // token and id exists
        response = await getUserById(id: id, token: token);
      }
    }
    catch(excep){
      response = errorResponse(excep);
    }

    return response;
  }

  /// The method setMinInfo is used to query jsut the name and email from the user for the drawer in home view
  Future setMinInfo() async {
    final response = await getUserInfo();

    if (response.data != null){
      // Succesfull query to the api gateway
      this._userName = '${response.data['getClient']['fName']} ${response.data['getClient']['sureName']}';
      this._email = response.data['getClient']['email'];
    }
    else{
      // Error in query
      this._userName = 'Bienvenido Usuario!';
      this._email = 'something@something.com';
    }
  }
}
