// Project imports:
import 'package:unuber_mobile/app/app.locator.dart';
import 'package:unuber_mobile/models/server_response_model.dart';
import 'package:unuber_mobile/services/api/errors/api_errors.dart';
import 'package:unuber_mobile/services/api/qraphql/mutations/credit_cards/create_credit_card.dart';
import 'package:unuber_mobile/services/api/qraphql/mutations/credit_cards/delete_credit_card.dart';
import 'package:unuber_mobile/services/api/qraphql/mutations/credit_cards/edit_credit_card.dart';
import 'package:unuber_mobile/services/api/qraphql/queries/credit_cards/credit_cards_list.dart';
import 'package:unuber_mobile/services/secure_storage/secure_storage_service.dart';

class CreditCardService {

  String token = "";
  String userId = "";

  final SecureStorageService _secureStorageService = locator<SecureStorageService>();

  Future <ServerResponseModel> createCreditCard ({
    required String cardNumber, required String dueDate, required int cvv
  }) async {

    ServerResponseModel response;
    await _getAccessToken();
    await _getAuthenticatedUserId();

    int idClient = int.parse(userId);

    try{
      response = await createCard(token, idClient: idClient, cardNumber: cardNumber, dueDate: dueDate, cvv: cvv);
    }
    catch (excep){
      response = errorResponse(excep);
    }

    return response;
  }

  Future <ServerResponseModel> userCreditCards () async {
    ServerResponseModel response;
    await _getAccessToken();

    await _getAuthenticatedUserId();

    int idClient = int.parse(userId);

    try{
      response = await listUserCreditCards(token, id: idClient);
    }
    catch (excep){
      response = errorResponse(excep);
    }

    return response;
  }

  Future <ServerResponseModel> updateCreditCard ({
    required int idCard, required String cardNumber, required String dueDate, required int cvv
  }) async {
    ServerResponseModel response;
    await _getAccessToken();
    await _getAuthenticatedUserId();

    int idClient = int.parse(userId);

    try{
      response = await editCardInfo(token, idCard: idCard, idClient: idClient, cardNumber: cardNumber, dueDate: dueDate, cvv: cvv);
    }
    catch (excep){
      response = errorResponse(excep);
    }

    return response;
  } 

  Future <ServerResponseModel> deleteCreditCard ({required int idCard}) async {
    ServerResponseModel response;
    await _getAccessToken();

    try{
      response = await deleteCard(token, idCard: idCard);
    }
    catch(excep){
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
