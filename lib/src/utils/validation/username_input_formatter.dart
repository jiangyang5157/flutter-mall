import 'package:flutter/services.dart';

import 'package:mall/src/utils/validation/validation.dart';

class UsernameInputFormatter implements TextInputFormatter {
  final RegexValidator regexValidator = RegexValidator('^[a-zA-Z0-9._]*\$');

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final oldValueValid = regexValidator.validate(oldValue.text);
    final newValueValid = regexValidator.validate(newValue.text);
    if (oldValueValid && !newValueValid) {
      return oldValue;
    }
    return newValue;
  }
}
