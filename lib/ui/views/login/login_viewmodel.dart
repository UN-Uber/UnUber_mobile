// Package imports:
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

// Project imports:
import 'package:unuber_mobile/app/app.locator.dart';
import 'package:unuber_mobile/app/app.router.dart';
import 'package:unuber_mobile/models/dialog_type.dart';
import 'package:unuber_mobile/models/server_response_model.dart';
import 'package:unuber_mobile/services/api/auth_services.dart';
import 'package:unuber_mobile/services/validations/login_validation_service.dart';
import 'package:unuber_mobile/utils/constraints.dart' as constraints;
import 'package:unuber_mobile/utils/logger.dart';

/// The class LoginViewModel is the ViewModel for the login route
class LoginViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  final _loginValidationService = locator<LoginValidationService>();
  final _authService = locator<AuthService>();

  /// flag to control the loading times
  bool _isLoading = false;

  /// Getter for the loading state
  bool get isLoading => _isLoading;

  /// Setter for the loading state
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  updateTelephone(bool value) {
    _loginValidationService.isTelephone = value;
    notifyListeners();
  }

  navigateToHome() {
    _navigationService.clearStackAndShow(Routes.homeView);
  }

  /// The method login is used to stablish a connection with the API Gateway and authorice the user
  Future login() async {
    String email = _loginValidationService.validEmail;
    String telephone = _loginValidationService.validTelephone;
    String password = _loginValidationService.validPassword;

    try {
      _isLoading = true;
      ServerResponseModel response = await _authService.getToken(
          email: email, telephone: telephone, password: password);
      _isLoading = false;

      if (!response.hasError)
        navigateToHome();
      else {
        switch (response.statusCode) {
          case 400:
            _showBasicDialog(description: constraints.CONNECTION_ERROR_MESSAGE);
            break;
          case 401:
            _showBasicDialog(
                description:
                    'Alguno de los parametros ingresados es incorrecto');
            break;
          default:
            _showBasicDialog(description: constraints.CONNECTION_ERROR_MESSAGE);
            CustomLogger().logger.e('error de servidor');
        }
      }
    } catch (excep) {
      CustomLogger().logger.e(excep);
      isLoading = false;
    }
  }

  /// The method _showBasicDialog display an error message to the user
  Future _showBasicDialog({required String description}) async {
    await _dialogService.showCustomDialog(
        variant: DialogType.SingleMessage,
        title: 'Error',
        description: description,
        mainButtonTitle: 'Ok');
    notifyListeners();
  }
}
