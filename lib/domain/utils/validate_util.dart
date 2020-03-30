import 'package:email_validator/email_validator.dart';

class ValidateUtil {
  ///Nullable
  static String validateEmail(String value) {
    if (value.isEmpty) {
      return "Enter email address";
    }

    if (EmailValidator.validate(value))
      return null;
    else
      return 'Email is not valid';
  }

  ///Nullable
  static String validatePassword(String password) {
    return password.length < 8
        ? "Password should be at least 8 characters"
        : null;
  }

  ///Nullable
  static String validateConfirmPassword(
      String password, String confirmPassword) {
    return password == confirmPassword ? null : "Passwords don't match";
  }
}
