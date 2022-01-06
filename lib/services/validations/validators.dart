// Dart imports:
import 'dart:async';
import 'package:intl/intl.dart';

class Validators {
  final validateEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
        _isEmail(email) && email.length > 1
        ? sink.add(email)
        : sink.addError('Ingrese un correo válido');
  });

  final validatePasswordSignup = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    password.length < 6 || password.contains(' ')
        ? sink.addError('Ingrese un mínimo de 6 caracteres sin espacios')
        : sink.add(password);
  });

  final validatePasswordLogin = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    password.length < 3
        ? sink.addError('Ingrese una contraseña válida')
        : sink.add(password);
  });

  static bool _isEmail(String value){
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  final validateCreditCardNumber = StreamTransformer<String, String>.fromHandlers(
    handleData: (creditCardNumber, sink) {
      _validateCardNumber(creditCardNumber) && creditCardNumber.length == 16
      ? sink.add(creditCardNumber) 
      : sink.addError('El número de la tarjeta no es válido.');
    }
  );

  final validateDueDate = StreamTransformer<String, String>.fromHandlers(
    handleData: (dueDate, sink){
      _validateDueDate(dueDate) && dueDate.length == 5
      ? sink.add(dueDate)
      : sink.addError('La tarjeta está vencida.');
    }
  );

  final validateCVV = StreamTransformer<String, String>.fromHandlers(
    handleData: (cvv, sink){
      _validateCVV(cvv)
      ? sink.add(cvv)
      : sink.addError('CVV no es válido.');
    }
  );


  ///   Lunh Algorithm 
  /// 
  ///   The _validateCardNumber function uses the Luhn Algorithm to check
  ///   if the input is a possible valid value for a Credit Card. Only accepts
  ///   the Visa and Mastercard cards which start with 4 and 5 respectively.

  static bool _validateCardNumber(String number){

    // First check if the number satisfies the Regex
    String pattern =  r'([4-5]{1}[0-9]{15})$';
    RegExp regExp = new RegExp(pattern);

    if(!regExp.hasMatch(number)) return false;

    // Takes every second digit starting form the right and
    // multiply it by two, and the add this value to the sum.
    // If the multiply give us a two digit number (is greather than 9) 
    // then subtract 9 from the number
    int sum = 0;
    for(var i = 0; i < number.length; i++){
      int digit = int.parse(number[number.length - i - 1]);

      if (i % 2 == 1){
        digit *= 2;
      }
      sum += digit > 9 ? (digit - 9) : digit;
    }

    // If the total sum is a multiple of 10, the credit card number is valid
    if (sum % 10 == 0) {
      return true;
    }

    return false;
  }


  ///   The _validateDueDate check if the credit card is expired or not

  static bool _validateDueDate(String date){

    if(date.length != 5) return false;
    
    // Get the current date in this format MM/YY
    final DateTime now = new DateTime.now();
    final DateFormat formatter = new DateFormat('MM/yy');
    final String currentDate = formatter.format(now);

    var currentDateParts = currentDate.split("/");
    var inputDateParts = date.split("/");

    // Compare by the year if the card is expired
    if(int.parse(currentDateParts[1]) > int.parse(inputDateParts[1])){
      return false;
    }

    // If the due date is in the current year then compare the current month with
    // the month in the due date and if the month has alredy passed then the card is expired.
    else if(int.parse(currentDateParts[1]) == int.parse(inputDateParts[1])){
      if(int.parse(currentDateParts[0]) > int.parse(inputDateParts[0])){
        return false;
      }
    }
    
    return true;
  }


  ///   The _validateCVV check by a regular expresion if the cvv is valid or not
  static bool _validateCVV(String cvv){
    String pattern = r'([0-9]{3})$';
    RegExp regExp = new RegExp(pattern);

    if(regExp.hasMatch(cvv)) return true;

    return false;
  }
}
