import 'package:mall/src/utils//validator.dart';

/// Validate given data, returns error message key or null if the data is valid.
class RepeatPasswordValidator implements Validator<String, String> {
  final String password;

  RepeatPasswordValidator(this.password);

  @override
  String validate(String data) {
    if (data != password) {
      return 'error_repeated_password_not_match';
    }
    return null;
  }
}
