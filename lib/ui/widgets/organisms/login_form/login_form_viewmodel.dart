// Package imports:
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

// Project imports:
import 'package:unuber_mobile/app/app.locator.dart';

class LoginFormViewModel extends BaseViewModel {
  final _navigationService= locator<NavigationService>();
  
  final String _title= 'login';
  final String _loginButtonText= 'Ingresar';
  final String _snackBarError= 'Verifica que los campos sean válidos';
  final String _googleButtonText= 'Ingresar con google';

  String get title => _title;
  String get loginButtonText => _loginButtonText;
  String get snackBarError => _snackBarError;
  String get googleButtonText => _googleButtonText;

  Stream<bool> get isValidForm => Stream.empty();
  Future navigateToForgotPassword() async {}
  changeEmail(String text) {}
  changePassword(String text) {}
}
