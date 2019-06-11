import 'package:mall/src/utils/utils.dart';

/// Validate given data, returns error message key or null if the data is valid.
class PasswordValidator implements Validator<String, String> {
  @override
  String validate(String data) {
    String trimmed = data.trim();
    if (trimmed.length <= 0) {
      return 'error_empty_password';
    }
    if (trimmed.contains(' ')) {
      return 'error_invalid_password';
    }
    return null;
  }
}
