// Package imports:
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

// Project imports:
import 'package:unuber_mobile/app/app.locator.dart';
import 'package:unuber_mobile/app/app.router.dart';
import 'package:unuber_mobile/models/dialog_type.dart';
import 'package:unuber_mobile/models/server_response_model.dart';
import 'package:unuber_mobile/services/api/credit_card_services.dart';
import 'package:unuber_mobile/services/validations/credit_card_validation_service.dart';
import 'package:unuber_mobile/utils/constraints.dart' as constraints;
import 'package:unuber_mobile/utils/logger.dart';

class NewCreditCardViewModel extends BaseViewModel {

  final CreditCardValidationService _creditCardValidationService = locator<CreditCardValidationService>();  
  final _dialogService = locator<DialogService>();
  final CreditCardService _creditCardService = locator<CreditCardService>();

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


  String get creditCardError => _creditCardValidationService.creditCardError;
  String get dueDateError => _creditCardValidationService.dueDateError;
  String get cvvError => _creditCardValidationService.cvvError;

  bool get isValidForm => _creditCardValidationService.validateForm();

  /// The method createCard is used to stablish a connection with the ApiGateway and
  /// Create a credit card for the authenticated user
  Future createCard() async {

    String cardNumber = _creditCardValidationService.validCreditCard.replaceAll(" ", "");
    String dueDate = _creditCardValidationService.validDueDate;
    int cvv = int.parse(_creditCardValidationService.validCvv);

    try{

      /// TODO: Get the authenticated user id
      ServerResponseModel response = await _creditCardService.createCreditCard(
        idClient: 57, 
        cardNumber: cardNumber, 
        dueDate: dueDate, 
        cvv: cvv
      );

      if(!response.hasError){
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
    catch (excep) {
      CustomLogger().logger.e(excep);
    }
  }

  /// The method _showBasicDialog display an error message to the user
  Future _showBasicDialog({required String description}) async {
    var response = await _dialogService.showCustomDialog(
        variant: DialogType.SingleMessage,
        title: 'Error',
        description: description,
        mainButtonTitle: 'Ok');
    notifyListeners();
  }

}
