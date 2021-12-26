import 'package:rxdart/rxdart.dart';
import 'package:unuber_mobile/services/validations/validators.dart';

class LoginValidationService with Validators {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  Stream<String> get emailStream =>
      _emailController.stream.transform(validateEmail);
  Stream<String> get passwordStream =>
      _passwordController.stream.transform(validatePasswordLogin);
  Stream<bool> get loginFormValidStream => Rx.combineLatest2(emailStream, passwordStream, (e, p) => true);

  Function(String) get changeEmail => _emailController.add;
  Function(String) get changePassword => _passwordController.sink.add;

  String? get email => _emailController.value;
  String? get password => _passwordController.value;

  dispose() {
    _emailController.close();
    _passwordController.close();
  }
}
