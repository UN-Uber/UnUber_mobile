// Package imports:
import 'package:intl/intl.dart';

/// The class validators is used to define the needed StreamTransformers to validate email and password correctness
class Validators {
  /// The method checkName is used to check if the given value is a valid name
  /// - @Param name is the string to be checked
  /// - return true if is a valid name, false other way
  bool checkName(String name){
    return name.length > 4;
  }

  /// The method checkSurename is used to check if the given value ia a valid surename
  /// - @Param surename is the string to be checked
  /// - return true if is a valid surename, false other way
  bool checkSurename(String surename){
    return surename.length > 4;
  }

  /// The method checkEmail is used to check if the given value is a valid email
  /// - @Param email is the string to be checked
  /// - return true if is a valid email, false other way
  bool checkEmail(String email) {
    return email.length > 4 && _checkRegEx(email, isEmail: true);
  }

  /// The method checkPasswordSignup is used to check if the given value is a valid password for signup
  /// - @Param password is the string to be checked
  /// - return true if is a valid password, false other way
  bool checkPasswordSignup(String password) {
    return password.length > 6 && !password.contains(' ');
  }

  /// The method checkConfirmPassword is used to check if the given values are the same password
  /// - @Param password is the first string to be compared
  /// - @Param confirmPassword is the second string to be compared
  /// - return true if is a valid password, false other way
  bool checkConfirmPassword(String password, String confirmPassword){
    return password.compareTo(confirmPassword) == 0;
  }

  /// The method checkPasswordLogin is used to check if the given value is a valid password for login
  /// - @Param password is the string to be checked
  /// - return true if is a valid password, false other way
  bool checkPasswordLogin(String password) {
    return password.length > 3;
  }

  /// The method checkTelephone is used to check if the given value is a valid telephone number
  /// - @Param number is the string to be checked
  /// - return true if is a valid number, false other way
  bool checkTelephone(String number) {
    return number.length > 4 && _checkRegEx(number);
  }

  /// Is used to check if the given value match the regular expression
  /// - @Param value is the string to be checked
  /// - @Param isEmail is a flag to check email or phone number
  /// - return true if match, false other way
  static bool _checkRegEx(String value, {bool isEmail = false}) {
    String pattern;

    // Select the pathern to use in the regex
    isEmail
        ? pattern =
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$'
        : pattern =
            '^(\\+\\d{1,2}\\s)?\\(?\\d{3}\\)?[\\s.-]?\\d{3}[\\s.-]?\\d{4}\$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }


  /// The method checkCreditCardNumber is used to check if the given value is a valid credit card
  /// - @Param card number in String
  /// - return true if is valid, and false other way
  bool checkCreditCardNumber(String creditCardNumber) {
    return _validateCardNumber(creditCardNumber) && creditCardNumber.length == 16;
  }

  /// The method checkDueDate is used to check if the given value is a valid due date
  /// - @Param due date in String
  /// - return true if is valid, and false other way
  bool checkDueDate(String dueDate) {
    return _validateDueDate(dueDate) && dueDate.length == 5;
  }

  /// The method checkCVV is used to check if the given value is a valid cvv
  /// - @Param cvv number in String
  /// - return true if is valid, and false other way
  bool checkCVV(String cvv) {
    return _validateCVV(cvv);
  }


  ///   Luhn Algorithm 
  /// 
  ///   The _validateCardNumber function uses the Luhn Algorithm to check
  ///   if the input is a possible valid value for a Credit Card. Only accepts
  ///   the Visa and Mastercard cards which start with 4 and 5 respectively.
  /// 
  ///   @param numbre is the number of the credit card to be checked
  ///   return true if the number pass with the verification of the Luhn Algorithm,
  ///          false if not.
  /// 
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
    else return false;
  }


  ///   The _validateDueDate check if the credit card is expired or not
  /// 
  ///   @param date is the due date of the credit card with this format -> MM/YY
  ///   return true if the due date is in the current month or future month,
  ///          false if the month has alredy passed.
  /// 
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
  /// 
  ///   @param cvv is the cvv number of the credit card to be checked
  ///   return true if the cvv match with the regex and false if it doesn't match this.
  /// 
  static bool _validateCVV(String cvv){
    String pattern = r'([0-9]{3})$';
    RegExp regExp = new RegExp(pattern);

    // I put the length verification anyway because for some reason the Regex also
    // accepted the cvv with lenght > 3.
    if(regExp.hasMatch(cvv) && cvv.length == 3) return true;

    return false;
  }
}