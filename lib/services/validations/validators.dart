/// The class validators is used to define the needed StreamTransformers to validate email and password correctness
class Validators {
  /// The method checkEmail is used to check if the given value is a valid email
  /// - @Param email is the string to be checked
  /// - return true if is a valid email, false other way.
  bool checkEmail(String email) {
    return email.length > 4 && _checkRegEx(email, isEmail: true);
  }

  /// The method checkPasswordSignup is used to check if the given value is a valid password for signup
  /// - @Param password is the string to be checked
  /// - return true if is a valid password, false other way.
  bool checkPasswordSignup(String password) {
    return password.length > 6 && !password.contains(' ');
  }

  /// The method checkPasswordLogin is used to check if the given value is a valid password for login
  /// - @Param password is the string to be checked
  /// - return true if is a valid password, false other way.
  bool checkPasswordLogin(String password) {
    return password.length > 3;
  }

  /// The method checkTelephone is used to check if the given value is a valid telephone number
  /// - @Param number is the string to be checked
  /// - return true if is a valid number, false other way.
  bool checkTelephone(String number) {
    return number.length > 4 && _checkRegEx(number);
  }

  /// Is used to check if the given value match the regular expression
  /// - @Param value is the string to be checked
  /// - @Param isEmail is a flag to check email or phone number
  /// - return true if match, false other way
  static bool _checkRegEx(String value, {bool isEmail = false}) {
    String pattern;

    // Select the pathern to use in the regex
    isEmail
        ? pattern =
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$'
        : pattern =
            '^(\\+\\d{1,2}\\s)?\\(?\\d{3}\\)?[\\s.-]?\\d{3}[\\s.-]?\\d{4}\$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }
}
