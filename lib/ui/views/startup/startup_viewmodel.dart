// Dart imports:
import 'dart:async';

// Package imports:
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

// Project imports:
import 'package:unuber_mobile/app/app.locator.dart';
import 'package:unuber_mobile/app/app.router.dart';

/// The class StartupViewModel is the ViewModel for the startup route
class StartupViewModel extends BaseViewModel {
  final _navigationService= locator<NavigationService>();

  StartupViewModel(){
    // Using a 3 seconds timer, then navigating to other route
    new Timer(const Duration(seconds: 3), _nextScreen);
  }

  /// The method _isSessionActive is used to check if the device has a token previously stored
  Future<bool> _isSessionActive() async {
    SharedPreferences prefs= await SharedPreferences.getInstance();
    String? token= prefs.getString('accessToken');
    return token != null;
  }

  /// The method _navigateToLogin is used to clear the widget tree and navigate to the login route
  Future _navigateToLogin() async {
    await _navigationService.clearStackAndShow(Routes.loginView);
  }

  /// The method _navigateToHome is used to clear the widget tree and navigate to the home route
  Future _navigateToHome() async {
    await _navigationService.clearStackAndShow(Routes.homeView);
  }

  /// The method _nextScreen is used to chose the next route to push into the widget tree
  _nextScreen() async {
    bool session= await _isSessionActive();
    if (!session){
      await _navigateToLogin();
    }
    else {
      await _navigateToHome();
    }
  }
}
