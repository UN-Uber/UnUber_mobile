// Package imports:
import 'package:stacked/stacked.dart';

// Project imports:
import 'package:unuber_mobile/app/app.locator.dart';
import 'package:unuber_mobile/services/validations/signup_validation_service.dart';

class SignupFormViewModel extends BaseViewModel {
  /// Is the srvice used to check if the email, telephone and password are valid inputs
  final SignupValidationService _signupValidationService =
      locator<SignupValidationService>();

  String _title= 'Registro';
  String _signupButtonText= 'Registrarme';
  String _snackBarError= 'Verifica que todos los campos sean válidos';

  /// Getter for the flag value
  bool get isValidForm => this._signupValidationService.validateForm();
  String get title => this._title;
  String get signupButtonText => this._signupButtonText;
  String get snackBarError => this._snackBarError;

  changeName(String text) {
    _signupValidationService.validateName(text);
    notifyListeners();
  }

  changeSurename(String text) {
    _signupValidationService.validateSurename(text);
    notifyListeners();
  }

  /// The method changeTelephone is used to update in real time the telephone to the validator
  changeTelephone(String text) {
    _signupValidationService.validateTelephone(text);
    notifyListeners();
  }

  /// The method changeEmail is used to update in real time the email to the validator
  changeEmail(String text) {
    _signupValidationService.validateEmail(text);
    notifyListeners();
  }

  /// The method changePassword is used to update in real time the password to the validator
  changePassword(String text) {
    _signupValidationService.validatePassword(text);
    notifyListeners();
  }

  /// The method changeConfirmPassword is used to update in real time the confirm password to the validator
  changeConfirmPassword(String text) {
    _signupValidationService.validateConfirmPassword(text);
    notifyListeners();
  }

  // Getters for inputs errors
  String get nameError => _signupValidationService.nameError;
  String get surenameError => _signupValidationService.surenameError;
  String get emailError => _signupValidationService.emailError;
  String get telephoneError => _signupValidationService.telephoneError;
  String get passwordError => _signupValidationService.passwordError;
  String get confirmPasswordError => _signupValidationService.confirmPasswordError;
}
