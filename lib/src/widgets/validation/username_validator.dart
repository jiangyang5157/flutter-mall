import 'package:mall/src/widgets/validation/validation.dart';
import 'package:mall/src/utils//validator.dart';

/// Validate given data, returns error message key or null if the data is valid.
class UsernameValidator implements Validator<String, String> {
  final RegexValidator regexValidator = RegexValidator('^[a-zA-Z0-9._]+\$');

  @override
  String validate(String data) {
    if (data.length <= 0) {
      return 'error_empty_username';
    }
    if (!regexValidator.validate(data)) {
      return 'error_invalid_username';
    }
    return null;
  }
}
