// Package imports:
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

// Project imports:
import 'package:unuber_mobile/app/app.locator.dart';
import 'package:unuber_mobile/app/app.router.dart';
import 'package:unuber_mobile/services/validations/login_validation_service.dart';

/// The class LoginFormViewModel is the ViewModel for the LoginFormView widget
class LoginFormViewModel extends BaseViewModel {
  /// Service used to navigate to other routes
  final NavigationService _navigationService = locator<NavigationService>();

  /// Service used to check if the email, telephone and password has valid inputs
  final _loginValidationService = locator<LoginValidationService>();

  /// Flag to identify if the user input is a telephone
  bool _isTelephone = false;

  /// Login form title
  final String _title = 'login';

  /// Submit button text
  final String _loginButtonText = 'Ingresar';

  /// Error message for snackbar popup
  final String _snackBarError = 'Verifica que todos los campos sean válidos';

  /// Google button text
  final String _googleButtonText = 'Ingresar con google';

  /// Getter for the flag value
  bool get isTelephone => _isTelephone;

  /// Getter for the title value
  String get title => _title;

  /// Getter for the loginButtonText value
  String get loginButtonText => _loginButtonText;

  /// Getter for the snackBarError value
  String get snackBarError => _snackBarError;

  /// Getter for the googleButtonText value
  String get googleButtonText => _googleButtonText;

  /// Getter for the isValidForm value
  bool get isValidForm => _loginValidationService.validateForm();

  /// The method navigateToForgotPassword is used to push the ForgotPassword route into the routes stack
  Future navigateToForgotPassword() async {
    _navigationService.navigateTo(Routes.forgotPasswordView);
    _loginValidationService.resetService();
  }

  /// The method navigateToSignup is used to push the Signup view into the routes stack
  Future navigateToSignup() async {
    _navigationService.navigateTo(Routes.signupView);
    _loginValidationService.resetService();
  }

  /// The method updateFlag is used to update the flag isTelephone and notify the view
  void updateFlag(bool value) {
    this._isTelephone = value;
    notifyListeners();
  }

  /// The method changeTelephone is used to update in real time the telephone to the validator
  changeTelephone(String text) {
    _loginValidationService.validateTelephone(text);
    notifyListeners();
  }

  /// The method changeEmail is used to update in real time the email to the validator
  changeEmail(String text) {
    _loginValidationService.validateEmail(text);
    notifyListeners();
  }

  /// The method changePassword is used to update in real time the password to the validator
  changePassword(String text) {
    _loginValidationService.validatePassword(text);
    notifyListeners();
  }

  String get emailError => _loginValidationService.emailError;
  String get telephoneError => _loginValidationService.telephoneError;
  String get passwordError => _loginValidationService.passwordError;
}
