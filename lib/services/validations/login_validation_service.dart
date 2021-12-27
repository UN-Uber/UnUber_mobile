// Package imports:
import 'package:rxdart/rxdart.dart';

// Project imports:
import 'package:unuber_mobile/services/validations/validators.dart';

class LoginValidationService with Validators {
  final _emailController = BehaviorSubject<String>.seeded('@');
  final _passwordController = BehaviorSubject<String>.seeded('');

  Stream<String> get email =>
      _emailController.stream.transform(validateEmail);
  Sink<String> get emailSink => _emailController.sink;

  Stream<String> get password =>
      _passwordController.stream.transform(validatePasswordLogin);
  Sink<String> get passwordSink => _passwordController.sink;

  Stream<bool> get loginFormValid =>
      Rx.combineLatest2(email, password, (e, p) => true);

  dispose() {
    _emailController.close();
    _passwordController.close();
  }
}
