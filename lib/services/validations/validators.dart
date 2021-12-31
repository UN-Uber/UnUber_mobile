// Dart imports:
import 'dart:async';

/// The class validators is used to define the needed StreamTransformers to validate email and password correctness
class Validators {
  /// Is the StreamTransformers used in email validation
  final validateEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
        _isEmail(email) && email.length > 1
        ? sink.add(email)
        : sink.addError('Ingrese un correo válido');
  });

  /// Is the StreamTransformers used in password validation for sign up
  final validatePasswordSignup = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    password.length < 6 || password.contains(' ')
        ? sink.addError('Ingrese un mínimo de 6 caracteres sin espacios')
        : sink.add(password);
  });

  /// Is the StreamTransformers used in password validation for login
  final validatePasswordLogin = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    password.length < 3
        ? sink.addError('Ingrese una contraseña válida')
        : sink.add(password);
  });

  /// Is used to check if the given value match the regular expression
  /// @Param value is the string to be checked
  /// return true if match, false other way
  static bool _isEmail(String value){
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }
}
