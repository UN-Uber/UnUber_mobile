// Package imports:
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

// Project imports:
import 'package:unuber_mobile/app/app.locator.dart';
import 'package:unuber_mobile/app/app.router.dart';
import 'package:unuber_mobile/models/credit_card.dart';
import 'package:unuber_mobile/models/dialog_type.dart';
import 'package:unuber_mobile/models/server_response_model.dart';
import 'package:unuber_mobile/services/api/credit_card_services.dart';
import 'package:unuber_mobile/utils/constraints.dart' as constraints;
import 'package:unuber_mobile/utils/logger.dart';

class CreditCardInfoViewModel extends BaseViewModel {

  final CreditCardService _creditCardService = locator<CreditCardService>();
  final _navigationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();

  navigateToCreditCardList() {
    _navigationService.clearStackAndShow(Routes.creditCardsListView);
  }

  Future deleteCard({required int idCard}) async {
    try{
      ServerResponseModel response = await _creditCardService.deleteCreditCard(idCard: idCard);

      if(!response.hasError){
        navigateToCreditCardList();
      }
      else{
        switch (response.statusCode) {
          case 400:
            _showBasicDialog(description: constraints.CONNECTION_ERROR_MESSAGE);
            break;
          case 401:
            _showBasicDialog(description: 'Alguno de los parametros ingresados es incorrecto');
            break;
          default:
            _showBasicDialog(description: constraints.CONNECTION_ERROR_MESSAGE);
            CustomLogger().logger.e('error de servidor');
        }
      }
    }
    catch (excep){
      CustomLogger().logger.e(excep);
    }
  }

  Future _showBasicDialog({required String description}) async {
    var response = await _dialogService.showCustomDialog(
        variant: DialogType.SingleMessage,
        title: 'Error',
        description: description,
        mainButtonTitle: 'Ok');
    notifyListeners();
  }

}