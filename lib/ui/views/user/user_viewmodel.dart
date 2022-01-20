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
import 'package:unuber_mobile/services/validations/signup_validation_service.dart';
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

  final SignupValidationService _signupValidationService =
      locator<SignupValidationService>();

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

  reloadFrame() {
    _navigationService.clearTillFirstAndShow(Routes.userView);
  }

  exitApp() {
    _navigationService.clearStackAndShow(Routes.loginView);
  }

  /// Is the title of the form
  String _title = 'Registro';

  /// Is the title of the submmit button
  String _signupButtonText = 'Registrarme';

  /// Is the error to display when some inputs are invalid and the submmit button was tapped
  String _snackBarError = 'Verifica que todos los campos sean válidos';

  /// Getter for the flag value
  bool get isValidForm => this._signupValidationService.validateForm();
  String get title => this._title;
  String get signupButtonText => this._signupButtonText;
  String get snackBarError => this._snackBarError;

  /// The method changeName is used to send the input name to the signup validation service
  changeName(String text) {
    _signupValidationService.validateName(text);
    notifyListeners();
  }

  /// The method changeSurename is used to send the input surename to the signup validation service
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
  /*changePassword(String text) {
    _signupValidationService.validatePassword(text);
    notifyListeners();
  }

  /// The method changeConfirmPassword is used to update in real time the confirm password to the validator
  changeConfirmPassword(String text) {
    _signupValidationService.validateConfirmPassword(text);
    notifyListeners();
  }
  */

  // Getters for inputs errors
  String get nameError => _signupValidationService.nameError;
  String get surenameError => _signupValidationService.surenameError;
  String get emailError => _signupValidationService.emailError;
  String get telephoneError => _signupValidationService.telephoneError;
  String get passwordError => _signupValidationService.passwordError;
  String get confirmPasswordError =>
      _signupValidationService.confirmPasswordError;

  /// The method login is used to stablish a connection with the API Gateway and authorice the user
  ///
  ///
  Future updateUser() async {
    String fName = _signupValidationService.validFirstName;
    String? sName = _signupValidationService.validSecondName;
    String sureName = _signupValidationService.validSurename;
    String email = _signupValidationService.validEmail;
    String telephone = _signupValidationService.validTelephone;
    //String password = _loginValidationService.validPassword;
    try {
      // Try to authorice in the api gateway and get an auth token
      _isLoading = true;
      ServerResponseModel response = await _userService.updateUserInfo(
          firstName: fName,
          secondName: sName,
          surename: sureName,
          active: 1,
          email: email,
          telephone: telephone);
      //ServerResponseModel response = await _authService.getToken(
      //  email: email, telephone: telephone, password: password);
      _isLoading = false;
      if (!response.hasError) {
        // query succesfull
        reloadFrame();
        _userService.setMinInfo();
      } else {
        // query has an error, so check for status code and do something
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

  Future<User> getUser() async {
    late User user;

    try {
      _isLoading = true;
      ServerResponseModel response = await _userService.getUserInfo();
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
        if (user.sName != null) {
          changeName(user.fName + " " + user.sName!);
        } else {
          changeName(user.fName);
        }
        changeSurename(user.sureName);
        changeTelephone(user.telNumber);
        changeEmail(user.email);
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

  Future deleteUser() async {
    try {
      // Try to authorice in the api gateway and get an auth token
      _isLoading = true;
      ServerResponseModel response = await _userService.deleteClientUser();
      //ServerResponseModel response = await _authService.getToken(
      //  email: email, telephone: telephone, password: password);
      _isLoading = false;
      if (!response.hasError) {
        // query succesfull
        exitApp();
      } else {
        // query has an error, so check for status code and do something
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
    var response = await _dialogService.showCustomDialog(
        variant: DialogType.SingleMessage,
        title: 'Error',
        description: description,
        mainButtonTitle: 'Ok');
    notifyListeners();
  }
}
