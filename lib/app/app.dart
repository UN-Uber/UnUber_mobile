import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:unuber_mobile/ui/views/startup/startup_view.dart';

@StackedApp(
  routes: [MaterialRoute(page: StartupView, 
  path: '/start' ,initial: true)],
  dependencies: [LazySingleton(classType: NavigationService)]
)
class AppSetup {}
