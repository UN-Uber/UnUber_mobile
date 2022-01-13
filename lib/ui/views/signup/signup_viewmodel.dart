// Package imports:
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

// Project imports:
import 'package:unuber_mobile/app/app.locator.dart';
import 'package:unuber_mobile/models/dialog_type.dart';
import 'package:unuber_mobile/models/server_response_model.dart';
import 'package:unuber_mobile/services/api/auth_services.dart';
import 'package:unuber_mobile/services/validations/signup_validation_service.dart';
import 'package:unuber_mobile/utils/constraints.dart' as constraints;
import 'package:unuber_mobile/utils/logger.dart';

class SignupViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final SignupValidationService _signupValidationService =
      locator<SignupValidationService>();
  final AuthService _authService = locator<AuthService>();
  final DialogService _dialogService = locator<DialogService>();

  bool _isLoading = false;

  bool get isLoading => this._isLoading;

  set isLoading(bool value) {
    this._isLoading = value;
    notifyListeners();
  }

  signup() async {
    String firstName = _signupValidationService.validFirstName;
    String? secondName = _signupValidationService.validSecondName;
    String surename = _signupValidationService.validSurename;
    String email = _signupValidationService.validEmail;
    String telephone = _signupValidationService.validTelephone;
    String password = _signupValidationService.validPassword;

    try {
      _isLoading = true;
      ServerResponseModel response = await _authService.signupNewUser(
          firstName: firstName,
          secondName: secondName,
          surename: surename,
          email: email,
          telephone: telephone,
          password: password);
      _isLoading = false;

      if (!response.hasError) {
        await _showBasicDialog(
            title: 'Registro éxitoso',
            description: 'El registro para el nuevo usuario a sido éxitoso');
        _navigationService.popRepeated(1);
        _signupValidationService.resetService();
      } else {
        switch (response.statusCode) {
          case 400:
            _showBasicDialog(
                title: 'Error',
                description: constraints.CONNECTION_ERROR_MESSAGE);
            break;
          case 401:
            _showBasicDialog(
                title: 'Error',
                description:
                    'Alguno de los parametros ingresados no fue correcto');
            break;
          default:
            _showBasicDialog(
                title: 'Error',
                description: constraints.CONNECTION_ERROR_MESSAGE);
            CustomLogger().logger.e('Error de servidor');
        }
      }
    } catch (excep) {
      CustomLogger().logger.e(excep);
      isLoading = false;
    }
  }

  Future _showBasicDialog(
      {required String title, required String description}) async {
    await _dialogService.showCustomDialog(
        variant: DialogType.SingleMessage,
        title: title,
        description: description,
        mainButtonTitle: 'Ok');
    notifyListeners();
  }
}
