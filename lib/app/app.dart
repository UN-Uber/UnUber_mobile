// Package imports:
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

// Project imports:
import 'package:unuber_mobile/services/api/auth_services.dart';
import 'package:unuber_mobile/services/api/credit_card_services.dart';
import 'package:unuber_mobile/services/api/user_services.dart';
import 'package:unuber_mobile/services/secure_storage/secure_storage_service.dart';
import 'package:unuber_mobile/services/validations/credit_card_validation_service.dart';
import 'package:unuber_mobile/services/validations/login_validation_service.dart';
import 'package:unuber_mobile/services/validations/signup_validation_service.dart';
import 'package:unuber_mobile/ui/views/credit_card/credit_card_list/credit_card_list_view.dart';
import 'package:unuber_mobile/ui/views/credit_card/new_credit_card/new_credit_card_view.dart';
import 'package:unuber_mobile/ui/views/forgot_password/forgot_password_view.dart';
import 'package:unuber_mobile/ui/views/home/home_view.dart';
import 'package:unuber_mobile/ui/views/login/login_view.dart';
import 'package:unuber_mobile/ui/views/signup/signup_view.dart';
import 'package:unuber_mobile/ui/views/startup/startup_view.dart';
import 'package:unuber_mobile/ui/views/user/user_view.dart';

/// The class AppSetup is used to define the routes and services to use for the auto-routing functionality
/// * @Routes is the array of routes to the views of the project
/// - StartupView is the view to load the app when open
/// - LoginView is the view to login into the app
/// - HomeView is the main view when logged in
/// - ForgotPasswordView is the view for password recovery
/// - NewCreditCardView is the view which the user can register a new credit card
/// - CreditCardsListView is the view to load the credit cards a user has
/// * @Dependencies is the array of services to use
/// - NavigationService is the service used to navigate between views
/// - DialogService is the service used to generate customized dialog alerts
/// - LoginValidationService is the service used to validate in real time the user inputs in the login view
/// - AuthService is the service to get authorization to use the API Gateway
@StackedApp(routes: [
  MaterialRoute(page: StartupView, path: '/start', initial: true),
  MaterialRoute(page: LoginView, path: '/login'),
  MaterialRoute(page: HomeView, path: '/home'),
  MaterialRoute(page: ForgotPasswordView, path: '/forgot'),
  MaterialRoute(page: UserView, path: '/user'),
  MaterialRoute(page: NewCreditCardView, path: '/new-credit-card'),
  MaterialRoute(page: CreditCardsListView, path: '/my-cards'),
  MaterialRoute(page: SignupView, path: '/signup')
], dependencies: [
  LazySingleton(classType: NavigationService),
  LazySingleton(classType: DialogService),
  LazySingleton(classType: LoginValidationService),
  LazySingleton(classType: CreditCardValidationService),
  LazySingleton(classType: AuthService),
  LazySingleton(classType: CreditCardService),
  LazySingleton(classType: SignupValidationService),
  LazySingleton(classType: SecureStorageService),
  LazySingleton(classType: UserService),
])
class AppSetup {}
