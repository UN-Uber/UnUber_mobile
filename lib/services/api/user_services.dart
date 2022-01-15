// Project imports:
import 'package:unuber_mobile/app/app.locator.dart';
import 'package:unuber_mobile/models/server_response_model.dart';
import 'package:unuber_mobile/services/api/errors/api_errors.dart';
import 'package:unuber_mobile/services/api/qraphql/queries/user/get_all_user.dart';
import 'package:unuber_mobile/services/secure_storage/secure_storage_service.dart';

class UserService {
  String token = "";
  String userId = "";

  final SecureStorageService _secureStorageService =
      locator<SecureStorageService>();
  Future<ServerResponseModel> getInfoFromUser() async {
    ServerResponseModel response;

    await _getAccessToken();
    await _getAuthenticatedUserId();
    int idClient = int.parse(userId);
    try {
      response = await getUserInfo(token, idClient);
    } catch (excep) {
      response = errorResponse(excep);
    }
    return response;
  }

  _getAccessToken() async {
    token = await _secureStorageService.getValue(key: 'authToken') ?? "";
  }

  _getAuthenticatedUserId() async {
    userId = await _secureStorageService.getValue(key: 'userId') ?? "";
  }
}
