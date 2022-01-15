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
import 'package:unuber_mobile/services/data_transfer/credit_card_data_service.dart';
import 'package:unuber_mobile/services/validations/credit_card_validation_service.dart';
import 'package:unuber_mobile/utils/constraints.dart' as constraints;
import 'package:unuber_mobile/utils/logger.dart';

class CreditCardInfoViewModel extends BaseViewModel {

  final CreditCardService _creditCardService = locator<CreditCardService>();
  final _navigationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();
  final CreditCardValidationService _creditCardValidationService = locator<CreditCardValidationService>();  
  final CreditCardDataService _creditCardDataService = locator<CreditCardDataService>();

  bool editEnable = false;
  bool updated = false;

  String get creditCardError => _creditCardValidationService.creditCardError;
  String get dueDateError => _creditCardValidationService.dueDateError;
  String get cvvError => _creditCardValidationService.cvvError;

  String get selectedCreditCardNumber => _creditCardDataService.selectedCreditCardNumber;
  String get selectedCreditCardDueDate => _creditCardDataService.selectedCreditCardDueDate;
  String get selectedCreditCardCvv => _creditCardDataService.selectedCreditCardCvv;

  String get creditCardNewValue => _creditCardValidationService.validCreditCard;
  String get dueDateNewValue => _creditCardValidationService.validDueDate;
  String get cvvNewValue => _creditCardValidationService.validCvv;

  navigateToCreditCardList() {
    _navigationService.clearStackAndShow(Routes.creditCardsListView);
  }

  enableEdit(){
    editEnable ? editEnable = false : editEnable = true;
    notifyListeners();
  }

  changeCreditCard(String value){
    _creditCardValidationService.validateCreditCard(value);
    notifyListeners();
  }

  changeDueDate(String value){
    _creditCardValidationService.validateDueDate(value);
    notifyListeners();
  }

  changeCvv(String value){
    _creditCardValidationService.validateCvv(value);
    notifyListeners();
  }

  bool dataAreChange(){
    print("--");
    print(selectedCreditCardCvv);
    print(cvvNewValue);
    print(selectedCreditCardCvv.compareTo(cvvNewValue));
    print(cvvNewValue.isNotEmpty);
    print("--");

    if((selectedCreditCardNumber.compareTo(creditCardNewValue) != 0 && creditCardNewValue.isNotEmpty ) || 
       (selectedCreditCardDueDate.compareTo(dueDateNewValue) != 0 && dueDateNewValue.isNotEmpty) ||
       (selectedCreditCardCvv.compareTo(cvvNewValue) != 0 && cvvNewValue.isNotEmpty)){
        
        return true;
    }
    return false;
  }

  Future updateCard({required int idCard}) async {
    String cardNumber = _creditCardValidationService.validCreditCard.replaceAll(" ", "");
    String dueDate = _creditCardValidationService.validDueDate;
    int cvv = int.parse(_creditCardValidationService.validCvv);
  
    try{
      ServerResponseModel response = await _creditCardService.updateCreditCard(
        idCard: idCard,
        cardNumber: cardNumber,
        dueDate: dueDate,
        cvv: cvv
      );

      if(!response.hasError){
        updated = true;
        notifyListeners();
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
    catch(excep){
      CustomLogger().logger.e(excep);
    }
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