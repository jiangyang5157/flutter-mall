import 'package:mall/src/utils/utils.dart';

/// Validate given data, returns error message key or null if the data is valid.
class EmailAddressValidator implements Validator<String, String> {
  @override
  String validate(String data) {
    // TODO: restriction
    String trimmed = data.trim();
    if (trimmed.length <= 0) {
      return 'error_empty_email_address';
    }
    if (trimmed.contains(' ')) {
      return 'error_invalid_email_address';
    }
    return null;
  }
}
