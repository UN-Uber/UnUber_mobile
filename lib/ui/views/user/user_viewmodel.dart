// Flutter imports:
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

// Package imports:
import 'package:unuber_mobile/app/app.locator.dart';
import 'package:unuber_mobile/models/user.dart';
import 'package:unuber_mobile/services/validations/login_validation_service.dart';
import 'package:unuber_mobile/app/app.router.dart';
import 'package:unuber_mobile/models/dialog_type.dart';
import 'package:unuber_mobile/models/server_response_model.dart';
import 'package:unuber_mobile/utils/constraints.dart' as constraints;
import 'package:unuber_mobile/utils/logger.dart';
import 'package:unuber_mobile/services/api/auth_services.dart';
import 'package:unuber_mobile/services/api/user_crud_service.dart';

/// The class HomeViewModel is the ViewModel for the home route
class UserViewModel extends BaseViewModel {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  final _loginValidationService = locator<LoginValidationService>();
  final _userService = locator<UserCRUDService>();

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
  Future<User> getUser() async {
    String email = _loginValidationService.validEmail;
    String telephone = _loginValidationService.validTelephone;
    String password = _loginValidationService.validPassword;

    late User user;

    try {
      _isLoading = true;
      ServerResponseModel response = await _userService.getUserInfo();
      print(response.data);
      _isLoading = false;
      if (!response.hasError) {
        user = new User(
            fName: response.data["getClient"]["fName"],
            sName: response.data["getClient"]["sName"],
            sureName: response.data["getClient"]["sureName"],
            active: response.data["getClient"]["active"],
            email: response.data["getClient"]["email"],
            telNumber: response.data["getClient"]["telNumber"],
            image: response.data["getClient"]["image"]);
      } else {
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
    return user;
  }

  /// The method _showBasicDialog display an error message to the user
  Future _showBasicDialog({required String description}) async {
    var response = await _dialogService.showCustomDialog(
        variant: DialogType.SingleMessage,
        title: 'Error',
        description: description,
        mainButtonTitle: 'Ok');
    notifyListeners();
  }
}
