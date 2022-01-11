// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

// Package imports:
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

// Project imports:
import '../services/api/auth_services.dart';
import '../services/secure_storage/secure_storage_service.dart';
import '../services/validations/login_validation_service.dart';
import '../services/validations/signup_validation_service.dart';

final locator = StackedLocator.instance;

void setupLocator({String? environment, EnvironmentFilter? environmentFilter}) {
// Register environments
  locator.registerEnvironment(
      environment: environment, environmentFilter: environmentFilter);

// Register dependencies
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => LoginValidationService());
  locator.registerLazySingleton(() => SignupValidationService());
  locator.registerLazySingleton(() => SecureStorageService());
  locator.registerLazySingleton(() => AuthService());
}
