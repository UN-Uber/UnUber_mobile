// Package imports:
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

// Project imports:
import 'package:unuber_mobile/app/app.locator.dart';
import 'package:unuber_mobile/models/dialog_Type.dart';

class LoginViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future login() async{}

  Future _showBasicDialog({required String description}) async {
    var response = await _dialogService.showCustomDialog(
        title: 'Error',
        description: description,
        mainButtonTitle: 'Ok',
        data: DialogType.SingleMessage);
    notifyListeners();
  }
}
