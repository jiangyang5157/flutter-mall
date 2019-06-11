import 'package:mall/src/utils/utils.dart';

/// Validate given data, returns error message key or null if the data is valid.
class UsernameValidator implements Validator<String, String> {
  @override
  String validate(String data) {
    String trimmed = data.trim();
    if (trimmed.length <= 0) {
      return 'error_empty_username';
    }
    if (trimmed.contains(' ')) {
      return 'error_invalid_username';
    }
    return null;
  }
}
