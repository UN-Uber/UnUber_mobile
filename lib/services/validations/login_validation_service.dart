// Project imports:
import 'package:unuber_mobile/services/validations/validators.dart';

/// The class LoginValidationService is used to validate the user inputs in real time in the login view
class LoginValidationService with Validators {
  /// Is the flag to select email or telephone as user
  bool isTelephone= false;
  /// Is the message to display when the email is invalid
  String _emailError= ' ';
  /// Is the message to display when the telephone is invalid
  String _telephoneError= ' ';
  /// Is the message to display when the password is invalid
  String _passwordError= ' ';
  /// Is the valid email to be send
  String validEmail= '';
  /// Is the valid telephone to be send
  String validTelephone= '';
  /// Is the valid password to be send
  String validPassword= '';

  // Error messages getters
  String get emailError => this._emailError;
  String get telephoneError => this._telephoneError;
  String get passwordError => this._passwordError;

  /// The method validateEmail is used to check if the given string is a valid email
  /// - @Param email is the string to be checked
  /// - return true if the given email is valid, false other way
  bool validateEmail(String email) {
    if (checkEmail(email)){
      // email is valid
      this._emailError= '';
      this.validEmail= email;
      return true;
    }
    else {
      // email is invalid
      this._emailError= 'Ingrese un correo válido';
      this.validEmail= '';
      return false;
    }
  }

  /// The method validateTelephone is used to check if the given string is a valid telephone number
  /// - @Param telephone is the string to be checked
  /// - return true if the given telephone is valid, false other way
  bool validateTelephone(String telephone) {
    if(checkTelephone(telephone)){
      // telephone is valid
      this._telephoneError= '';
      this.validTelephone= telephone;
      return true;
    }
    else{
      // telephone is invalid
      this._telephoneError= 'Ingrese un número telefonico válido';
      this.validTelephone= '';
      return false;
    }
  }

  /// The method validatePassword is used to check if the given string is a valid password
  /// - @Param password is the string to be checked
  /// - return true if the given password is valid, false other way
  bool validatePassword(String password) {
    if (checkPasswordLogin(password)){
      // password is valid
      this._passwordError='';
      this.validPassword= password;
      return true;
    }
    else{
      // password is invalid
      this._passwordError= 'Ingrese una contraseña válida';
      this.validPassword= '';
      return false;
    }
  }

  /// The method validateForm is used to check if the valid given values
  /// - return true if all the values are valid, false other way
  bool validateForm(){
    if (isTelephone) return _telephoneError.isEmpty && _passwordError.isEmpty;
    else return _emailError.isEmpty && _passwordError.isEmpty;
  }
}
