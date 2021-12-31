// Package imports:
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

// Project imports:
import 'package:unuber_mobile/app/app.locator.dart';
import 'package:unuber_mobile/app/app.router.dart';
import 'package:unuber_mobile/models/dialog_Type.dart';

/// The class LoginViewModel is the ViewModel for the login route
class LoginViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  bool _isLoading = false;

  /// Getter for the loading state
  bool get isLoading => _isLoading;

  /// Setter for the loading state
  set _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  /// The method login is used to stablish a connection with the API Gateway and authorice the user
  Future login() async{
    _navigationService.clearStackAndShow(Routes.homeView);
  }

  /// The method _showBasicDialog display an error message to the user
  Future _showBasicDialog({required String description}) async {
    var response = await _dialogService.showCustomDialog(
        title: 'Error',
        description: description,
        mainButtonTitle: 'Ok',
        data: DialogType.SingleMessage);
    notifyListeners();
  }
}
