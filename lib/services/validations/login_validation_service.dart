// Package imports:
import 'package:rxdart/rxdart.dart';

// Project imports:
import 'package:unuber_mobile/services/validations/validators.dart';

/// The class LoginValidationService is used to validate the user inputs in real time in the login view
class LoginValidationService with Validators {
  final _emailController = BehaviorSubject<String>.seeded('@');
  final _passwordController = BehaviorSubject<String>.seeded('');

  /// Return the modified stream given a StreamTransformer and the user input email
  Stream<String> get email => _emailController.stream.transform(validateEmail);
  /// Return the listener for changes in order to update the email stream
  Sink<String> get emailSink => _emailController.sink;

  /// Return the modified stream given a StreamTransformer and the user input password
  Stream<String> get password =>
      _passwordController.stream.transform(validatePasswordLogin);
  /// Return the listener for changes in order to update the password stream
  Sink<String> get passwordSink => _passwordController.sink;

  /// Return the combined stream of the transforms of email and password using a combinator function to check if login is valid
  Stream<bool> get loginFormValid =>
      Rx.combineLatest2(email, password, (e, p) => true);

  /// Used to avoid memory leaks when using streams
  dispose() {
    _emailController.close();
    _passwordController.close();
  }
}
