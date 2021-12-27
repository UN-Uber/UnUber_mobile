// Package imports:
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

// Project imports:
import 'package:unuber_mobile/app/app.locator.dart';
import 'package:unuber_mobile/app/app.router.dart';
import 'package:unuber_mobile/services/validations/login_validation_service.dart';

class LoginFormViewModel extends MultipleStreamViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final LoginValidationService _loginValidationService =
      locator<LoginValidationService>();

  final String _emailKey = 'email-stream';
  final String _passwordKey = 'password-stream';
  final String _validFormKey = 'validForm-stream';
  final String _title = 'login';
  final String _loginButtonText = 'Ingresar';
  final String _snackBarError = 'Verifica que los campos sean válidos';
  final String _googleButtonText = 'Ingresar con google';

  String get emailKey => _emailKey;
  String get passwordKey => _passwordKey;
  String get validFormKey => _validFormKey;
  String get title => _title;
  String get loginButtonText => _loginButtonText;
  String get snackBarError => _snackBarError;
  String get googleButtonText => _googleButtonText;
  Stream<bool> get isValidForm => _loginValidationService.loginFormValid;

  Future navigateToForgotPassword() async {
    _navigationService.navigateTo(Routes.forgotPasswordView);
  }

  @override
  Map<String, StreamData> get streamsMap => {
        _emailKey: StreamData(_loginValidationService.email),
        _passwordKey: StreamData(_loginValidationService.password),
        _validFormKey: StreamData(_loginValidationService.loginFormValid)
      };

  changeEmail(String text) => _loginValidationService.emailSink.add(text);
  changePassword(String text) => _loginValidationService.passwordSink.add(text);
}
