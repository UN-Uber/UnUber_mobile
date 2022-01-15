// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

// Project imports:
import 'package:unuber_mobile/app/app.locator.dart';
import 'package:unuber_mobile/app/app.router.dart';

/// The class HomeViewModel is the ViewModel for the home route
class HomeViewModel extends BaseViewModel {
  /// Is the service uset to navigate to other views
  final _navigationService = locator<NavigationService>();

  /// Is a key used to get the [BuildContext] in other components
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();

  /// The method navigateToSetPoints is used to navigate to the set points view
  navigateToSetPoints() {
    _navigationService.navigateTo(Routes.setPointsView);
  }
}
