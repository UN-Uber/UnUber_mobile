// Dart imports:
import 'dart:async';

// Package imports:
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

// Project imports:
import 'package:unuber_mobile/app/app.locator.dart';
import 'package:unuber_mobile/app/app.router.dart';

class StartupViewModel extends BaseViewModel {
  final _navigationService= locator<NavigationService>();

  StartupViewModel(){
    new Timer(const Duration(seconds: 3), _nextScreen);
  }

  Future<bool> _isSessionActive() async {
    SharedPreferences prefs= await SharedPreferences.getInstance();
    String? token= prefs.getString('accessToken');
    return token != null;
  }

  Future _navigateToLogin() async {
    await _navigationService.clearStackAndShow(Routes.loginView);
  }

  Future _navigateToHome() async {
    await _navigationService.clearStackAndShow(Routes.homeView);
  }

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
