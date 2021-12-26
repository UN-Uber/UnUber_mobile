// Package imports:
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

// Project imports:
import 'package:unuber_mobile/services/validations/login_validation_service.dart';
import 'package:unuber_mobile/ui/views/home/home_view.dart';
import 'package:unuber_mobile/ui/views/login/login_view.dart';
import 'package:unuber_mobile/ui/views/startup/startup_view.dart';

@StackedApp(routes: [
  MaterialRoute(page: StartupView, path: '/start', initial: true),
  MaterialRoute(page: LoginView, path: '/login'),
  MaterialRoute(page: HomeView, path: '/home')
], dependencies: [
  LazySingleton(classType: NavigationService),
  LazySingleton(classType: DialogService),
  LazySingleton(classType: LoginValidationService)
])
class AppSetup {}
