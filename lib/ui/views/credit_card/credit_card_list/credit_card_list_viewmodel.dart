// Package imports:
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

// Project imports:
import 'package:unuber_mobile/app/app.locator.dart';
import 'package:unuber_mobile/app/app.router.dart';
import 'package:unuber_mobile/models/credit_card.dart';
import 'package:unuber_mobile/models/server_response_model.dart';
import 'package:unuber_mobile/services/api/credit_card_services.dart';
import 'package:unuber_mobile/utils/constraints.dart' as constraints;
import 'package:unuber_mobile/utils/logger.dart';

class CreditCardListViewModel extends BaseViewModel {

  List<CreditCard> cards = [];
  final _navigationService = locator<NavigationService>();
  
  navigateToAddCreditCard() {
    _navigationService.navigateTo(Routes.newCreditCardView);
  }

  /// The method listUserCards is used to stablish a connection with the ApiGateway and
  /// get the list of the credit card that the autheticated user have
  /// - return a List which items are type of CreditCard.
  Future<List<CreditCard>> listUserCards() async {

    final CreditCardService _creditCardService = locator<CreditCardService>();

    try{

      /// TODO: Get the authenticated user id
      ServerResponseModel response = await _creditCardService.userCreditCards();
      if(!response.hasError){

        /// Gets the array of CreditCards from the response data and iterates over it
        for(final i in response.data['getCardsClient']){
          
          CreditCard card = new CreditCard(
            idCard: i['idCard'],
            idClient: i['idClient'],
            creditCardNumber: int.parse(i['cardNumber']),
            dueDate: i['dueDate'],
            cvv: i['cvv'].toString()
          );
          cards.add(card);  
        }
        
      }
      else{
        switch (response.statusCode) {
          case 400:
            print(constraints.CONNECTION_ERROR_MESSAGE);
            break;
          case 401:
            print('Alguno de los parametros ingresados es incorrecto');
            break;
          default:
            print(constraints.CONNECTION_ERROR_MESSAGE);
            CustomLogger().logger.e('error de servidor');
        }
      }    
    }
    catch (excep){
      CustomLogger().logger.e(excep);
    }

    return cards;
  }
}
