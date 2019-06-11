import 'package:mall/src/utils/utils.dart';

/// Validate given data, returns error message key or null if the data is valid.
class PasswordValidator implements Validator<String, String> {
  final RegexValidator regexValidator = RegexValidator('^[a-zA-Z0-9._]+\$');

  @override
  String validate(String data) {
    if (data.length <= 0) {
      return 'error_empty_password';
    }
    if (!regexValidator.validate(data)) {
      return 'error_invalid_passowrd';
    }
    return null;
  }
}
