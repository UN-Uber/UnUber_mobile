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

/// The class SignupViewModel is the viewmodel for the signup view
class SignupViewModel extends BaseViewModel {
  /// Service used to navigate to other routes
  final NavigationService _navigationService = locator<NavigationService>();
  /// Service used to validate the user inputs in the signup view
  final SignupValidationService _signupValidationService =
      locator<SignupValidationService>();
  /// Service used to manage the auth graphql quryes and mutaions
  final AuthService _authService = locator<AuthService>();
  /// Service to generate custom dialog in the screen
  final DialogService _dialogService = locator<DialogService>();

  /// Is a flag used to set a loading animation when an asynchronous process is executing
  bool _isLoading = false;

  // Getters
  bool get isLoading => this._isLoading;

  // Setters
  set isLoading(bool value) {
    this._isLoading = value;
    notifyListeners();
  }

  /// The method signup is used to register a new user in the api gateway
  signup() async {
    // Collect all needed info
    String firstName = _signupValidationService.validFirstName;
    String? secondName = _signupValidationService.validSecondName;
    String surename = _signupValidationService.validSurename;
    String email = _signupValidationService.validEmail;
    String telephone = _signupValidationService.validTelephone;
    String password = _signupValidationService.validPassword;

    try {
      // try to create the new user in the api gateway
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
        // query succesfull
        await _showBasicDialog(
            title: 'Registro éxitoso',
            description: 'El registro para el nuevo usuario a sido éxitoso');
        _navigationService.popRepeated(1);
        _signupValidationService.resetService();
      } else {
        // query has error, so check the status code and do something
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

  /// The method _showBasicDialog is used to display a custom dialog to the user
  /// - @Param title is the title for the dialog
  /// - @Param description is the string to use as the dialog description
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
