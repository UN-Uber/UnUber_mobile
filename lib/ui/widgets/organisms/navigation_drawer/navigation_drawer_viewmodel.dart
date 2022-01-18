// Package imports:
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

// Project imports:
import 'package:unuber_mobile/app/app.locator.dart';
import 'package:unuber_mobile/app/app.router.dart';
import 'package:unuber_mobile/services/api/user_crud_service.dart';
import 'package:unuber_mobile/services/secure_storage/secure_storage_service.dart';
import 'package:unuber_mobile/services/validations/login_validation_service.dart';

/// The class NavigationDrawerViewModel is the viewmodel for the Navigation Drawer
class NavigationDrawerViewModel extends BaseViewModel {
  /// Service used to navigate to others routes
  final _navigationService = locator<NavigationService>();

  /// Service used to validate the user inputs in the login view
  final _loginValiddationService = locator<LoginValidationService>();

  /// Service used to encrypt and persist some data
  final _secureStorageService = locator<SecureStorageService>();

  /// Service used to manage the graphql queries and mutations for the user data
  final _userCRUDService = locator<UserCRUDService>();

  /// Is the user name to display in the drawer
  late String _user = _userCRUDService.userName;

  /// Is the email of the user to display in the drawer
  late String _email = _userCRUDService.email;

  /// Is the image of the user to display in the drawer
  String _profileImage = 'assets/images/default_profile_image.png';

  /// Is the background image to disply in the user info card
  String _landscape = 'assets/images/decoration_landscape.jpg';

  // Getters
  String get user => _user;
  String get email => _email;
  String get profileImage => _profileImage;
  String get landscape => _landscape;

  /// The method logout is used to delete the auth token and logout from the app
  logout() async {
    await _secureStorageService.delete(key: 'authToken');
    await _secureStorageService.delete(key: 'userId');
    _loginValiddationService.resetService();
    _navigationService.clearStackAndShow(Routes.loginView);
  }

  /// The method goToCreditCard is used to navigate to the credit cards view
  goToCreditCard() async {
    _navigationService.navigateTo(Routes.creditCardsListView);
  }

  goToAccount() async {
    _navigationService.navigateTo(Routes.userView);
  }
}
