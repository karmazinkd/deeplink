import 'package:deeplinktest/ui/utils/strings.dart';
import 'package:email_validator/email_validator.dart';

class ValidateUtil {
  ///Validates the given [value] as an email
  ///Returns `null` on successful validation, otherwise String with failure message
  ///Nullable
  static String validateEmail(String value) {
    if (value.isEmpty) {
      return Strings.enterEmailAddress;
    }

    if (EmailValidator.validate(value))
      return null;
    else
      return Strings.emailNotValid;
  }

  ///Validates the given [password]
  ///Returns `null` on successful validation, otherwise String with failure message
  ///Nullable
  static String validatePassword(String password) {
    return password.length < 8
        ? Strings.passwordShouldBe8Chars
        : null;
  }

  ///Validates two given passwords [password], [confirmPassword]
  ///Returns `null` on successful validation, otherwise String with failure message
  ///Nullable
  static String validateConfirmPassword(
      String password, String confirmPassword) {
    return password == confirmPassword ? null : Strings.passwordsDontMatch;
  }
}
