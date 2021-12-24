// Package imports:
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

// Project imports:
import 'package:unuber_mobile/ui/views/login/login_view.dart';
import 'package:unuber_mobile/ui/views/startup/startup_view.dart';

@StackedApp(routes: [
  MaterialRoute(page: StartupView, path: '/start'),
  MaterialRoute(page: LoginView, path: '/login', initial: true)
], dependencies: [
  LazySingleton(classType: NavigationService),
  LazySingleton(classType: DialogService)
])
class AppSetup {}
