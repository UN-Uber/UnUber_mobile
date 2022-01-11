// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:unuber_mobile/services/validations/validators.dart';

class CreditCardValidationService with Validators {
  
  String _creditCardError = ' ';
  String _dueDateError = ' ';
  String _cvvError = ' ';

  String validCreditCard = '';
  String validDueDate = '';
  String validCvv = '';

  String get creditCardError => this._creditCardError;
  String get dueDateError => this._dueDateError;
  String get cvvError => this._cvvError;


  /// The method validateCreditCard is used to check if the given value is a valid credit card
  /// - @Param card number in String
  /// - return true if is valid, and false other way
  bool validateCreditCard(String cardNumber){
    if(checkCreditCardNumber(cardNumber)){
      this._creditCardError = '';
      this.validCreditCard = cardNumber;
      return true;
    }
    else{
      this._creditCardError = "El número de la tarjeta no es válido";
      this.validCreditCard = '';
      return false;
    }
  }

  /// The method validateDueDate is used to check if the given value is a valid due date
  /// - @Param due date in String
  /// - return true if is valid, and false other way
  bool validateDueDate(String date){
    if(checkDueDate(date)){
      this._dueDateError = '';
      this.validDueDate = date;
      return true;
    }
    else{
      this._dueDateError = "La tarjeta está vencida";
      this.validDueDate = '';
      return false;
    }
  }

  /// The method checkCVV is used to check if the given value is a valid cvv
  /// - @Param cvv number in String
  /// - return true if is valid, and false other way
  bool validateCvv(String cvv){
    if(checkCVV(cvv)){
      this._cvvError = '';
      this.validCvv = cvv;
      return true;
    }
    else{
      this._cvvError = 'CVV no es válido';
      this.validCvv = '';
      return false;
    }
  }

  /// The method validateForm is used to check if the given values are valid before submit
  /// - return true if all the values are valid, false other way
  bool validateForm() {
    return _creditCardError.isEmpty && _dueDateError.isEmpty && _cvvError.isEmpty;
  }
}
