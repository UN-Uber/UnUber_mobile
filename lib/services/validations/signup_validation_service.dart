// Project imports:
import 'package:unuber_mobile/services/validations/validators.dart';

class SignupValidationService extends Validators {
  String _nameError = ' ';
  String _surenameError = ' ';
  String _emailError = ' ';
  String _telephoneError = ' ';
  String _passwordError = ' ';
  String _confirmPasswordError = ' ';
  String validFirstName = '';
  String validSurename = '';
  String validEmail = '';
  String validTelephone = '';
  String validPassword = '';
  String? validSecondName;

  //Getters
  String get nameError => this._nameError;
  String get surenameError => this._surenameError;
  String get emailError => this._emailError;
  String get telephoneError => this._telephoneError;
  String get passwordError => this._passwordError;
  String get confirmPasswordError => this._confirmPasswordError;

  /// The method validateName is used to check if the given string is a valid name
  /// - @Param name is the string to be checked
  /// - return  true if the given name is valid, false other way
  bool validateName(String name) {
    if (checkName(name)) {
      // name is valid
      List<String> names = name.split(' ');

      this.validFirstName = names[0];
      if (names.length > 1) this.validSecondName = names[1];
      this._nameError = '';
      return true;
    } else {
      // name is invalid
      this.validFirstName = '';
      this.validSecondName = '';
      this._nameError = 'Ingrese un nombre válido';
      return false;
    }
  }

  /// The method validateSurename is used to check if the given string is a valid surename
  /// - @Param surename is the string to be checked
  /// - reeturn true if the given surename is valid, false other way
  bool validateSurename(String surename) {
    if (checkSurename(surename)) {
      // surename is valid
      this.validSurename = surename;
      this._surenameError = '';
      return true;
    } else {
      // surename is invalid
      this.validSurename = '';
      this._surenameError = 'Ingrese un apellido válido';
      return false;
    }
  }

  /// The method validateEmail is used to check if the given string is a valid email
  /// - @Param email is the string to be checked
  /// - return true if the given email is valid, false other way
  bool validateEmail(String email) {
    if (checkEmail(email)) {
      // email is valid
      this._emailError = '';
      this.validEmail = email;
      return true;
    } else {
      // email is invalid
      this._emailError = 'Ingrese un correo válido';
      this.validEmail = '';
      return false;
    }
  }

  /// The method validateTelephone is used to check if the given string is a valid telephone number
  /// - @Param telephone is the string to be checked
  /// - return true if the given telephone is valid, false other way
  bool validateTelephone(String telephone) {
    if (checkTelephone(telephone)) {
      // telephone is valid
      this._telephoneError = '';
      this.validTelephone = telephone;
      return true;
    } else {
      // telephone is invalid
      this._telephoneError = 'Ingrese un número telefonico válido';
      this.validTelephone = '';
      return false;
    }
  }

  /// The method validatePasswordSignup is used to check if the given string is a valid password
  /// - @Param password is the string to be checked
  /// - return true if the given password is valid, false other way
  bool validatePassword(String password) {
    if (checkPasswordSignup(password)) {
      // password is valid
      this._passwordError = '';
      this.validPassword = password;
      return true;
    } else {
      // password is invalid
      this._passwordError = 'Ingrese una contraseña válida';
      this.validPassword = '';
      return false;
    }
  }

  /// The method validateConfirmPassword is used to check if the given string is the same as the input password
  /// - @Param confirmPassword is the string to be compared
  /// - return true if the given password is valid, false other way
  bool validateConfirmPassword(String confirmPassword) {
    var value = checkConfirmPassword(this.validPassword, confirmPassword);

    // passwords are the same
    if (value)
      this._confirmPasswordError = '';
    // passwords are different
    else
      this._confirmPasswordError = 'Ingrese una contraseña coincidente';

    return value;
  }

  /// The method validateForm is used to check if the given values are valid
  /// - return true if all the values are valid, false other way
  bool validateForm() {
    return _nameError.isEmpty &&
        _surenameError.isEmpty &&
        _emailError.isEmpty &&
        _telephoneError.isEmpty &&
        _passwordError.isEmpty &&
        _confirmPasswordError.isEmpty;
  }

  /// The method resetService is used to reset all the service attibutes
  void resetService() {
    this._nameError = ' ';
    this._surenameError = ' ';
    this._emailError = ' ';
    this._telephoneError = ' ';
    this._passwordError = ' ';
    this._confirmPasswordError = ' ';
    this.validFirstName = '';
    this.validSurename = '';
    this.validEmail = '';
    this.validTelephone = '';
    this.validPassword = '';
    this.validSecondName = null;
  }
}
