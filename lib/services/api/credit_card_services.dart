// Package imports:
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
import 'package:unuber_mobile/models/server_response_model.dart';
import 'package:unuber_mobile/services/api/errors/api_errors.dart';
import 'package:unuber_mobile/services/api/qraphql/mutations/credit_cards/create_credit_card.dart';
import 'package:unuber_mobile/services/api/qraphql/mutations/credit_cards/delete_credit_card.dart';
import 'package:unuber_mobile/services/api/qraphql/mutations/credit_cards/edit_credit_card.dart';
import 'package:unuber_mobile/services/api/qraphql/queries/credit_cards/credit_cards_list.dart';

class CreditCardService {

  String token = "";

  Future <ServerResponseModel> createCreditCard ({
    required int idClient, required String cardNumber, required String dueDate, required int cvv
  }) async {

    ServerResponseModel response;
    await _getAccessToken();

    try{
      response = await createCard(token, idClient: idClient, cardNumber: cardNumber, dueDate: dueDate, cvv: cvv);
    }
    catch (excep){
      response = errorResponse(excep);
    }

    return response;
  }

  Future <ServerResponseModel> userCreditCards ({required int idClient}) async {
    ServerResponseModel response;
    await _getAccessToken();

    try{
      response = await listUserCreditCards(token, id: idClient);
    }
    catch (excep){
      response = errorResponse(excep);
    }

    return response;
  }

  Future <ServerResponseModel> updateCreditCard ({
    required int idCard, required int idClient, required String cardNumber, required String dueDate, required int cvv
  }) async {
    ServerResponseModel response;
    await _getAccessToken();

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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token =  prefs.getString("authToken") ?? "";
  }
}
