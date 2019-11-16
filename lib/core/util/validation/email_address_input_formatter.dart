import 'package:flutter/services.dart';

import 'package:mall/core/util/validation/regex_validator.dart';

class EmailAddressInputFormatter implements TextInputFormatter {
  final RegexValidator regexValidator =
      RegexValidator('^[a-zA-Z0-9._]*(@([a-zA-Z0-9-]+(\.([a-zA-Z]*)?)?)?)?\$');

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
