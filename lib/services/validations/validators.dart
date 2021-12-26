import 'dart:async';

class Validators {
  final validateEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    regExp.hasMatch(email)
        ? sink.add(email)
        : sink.addError('Ingrese un correo válido');
  });

  final validatePasswordSignup = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    password.length < 6 || password.contains(' ')
        ? sink.addError('Ingrese un mínimo de 6 caracteres sin espacios')
        : sink.add(password);
  });

  final validatePasswordLogin = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    password.length < 0
        ? sink.addError('Ingrese su contraseña')
        : sink.add(password);
  });
}
