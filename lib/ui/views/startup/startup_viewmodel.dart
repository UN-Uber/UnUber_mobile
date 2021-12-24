// Package imports:
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

// Project imports:
import 'package:unuber_mobile/app/app.locator.dart';
import 'package:unuber_mobile/ui/views/login/login_view.dart';

class StartupViewModel extends BaseViewModel {
  final _navigationService= locator<NavigationService>();

  Future handleStartupLogic() async {
    _navigationService.navigateToView(LoginView());
  }
}
