// Package imports:
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

// Project imports:
import 'package:unuber_mobile/app/app.locator.dart';
import 'package:unuber_mobile/app/app.router.dart';
import 'package:unuber_mobile/services/validations/login_validation_service.dart';

/// The class LoginFormViewModel is the ViewModel for the LoginFormView widget
class LoginFormViewModel extends MultipleStreamViewModel {
  /// Service used to navigate to other routes
  final NavigationService _navigationService = locator<NavigationService>();
  /// Service used to check if the email and password has valid inputs
  final LoginValidationService _loginValidationService =
      locator<LoginValidationService>();

  /// Key to identify the email error
  final String _emailKey = 'email-stream';
  /// Key to identify the password error
  final String _passwordKey = 'password-stream';
  /// Key to adentify the form error
  final String _validFormKey = 'validForm-stream';
  /// Login form title
  final String _title = 'login';
  /// Submit button text
  final String _loginButtonText = 'Ingresar';
  /// Error message for snackbar popup
  final String _snackBarError = 'Verifica que los campos sean válidos';
  /// Google button text
  final String _googleButtonText = 'Ingresar con google';

  /// Getter for the emailKey value
  String get emailKey => _emailKey;
  /// Getter for the passwordKey value
  String get passwordKey => _passwordKey;
  /// Getter for the validFormKey value
  String get validFormKey => _validFormKey;
  /// Getter for the title value
  String get title => _title;
  /// Getter for the loginButtonText value
  String get loginButtonText => _loginButtonText;
  /// Getter for the snackBarError value
  String get snackBarError => _snackBarError;
  /// Getter for the googleButtonText value
  String get googleButtonText => _googleButtonText;
  /// Getter for the isValidForm value
  Stream<bool> get isValidForm => _loginValidationService.loginFormValid;

  /// The method navigateToForgotPassword is used to push the ForgotPassword route into the routes stack
  Future navigateToForgotPassword() async {
    _navigationService.navigateTo(Routes.forgotPasswordView);
  }

  /// The method changeEmail is used to update in real time the email to the validator
  changeEmail(String text) => _loginValidationService.emailSink.add(text);
  /// The method changePassword is used to update in real time the password to the validator
  changePassword(String text) => _loginValidationService.passwordSink.add(text);

  @override
  Map<String, StreamData> get streamsMap => {
        _emailKey: StreamData(_loginValidationService.email),
        _passwordKey: StreamData(_loginValidationService.password),
        _validFormKey: StreamData(_loginValidationService.loginFormValid)
      };
}
