import 'package:mall/src/utils//validator.dart';

class RegexValidator implements Validator<String, bool> {
  RegexValidator(this.regex);

  final String regex;

  @override
  bool validate(String data) {
    final regExp = RegExp(regex);
    final matches = regExp.allMatches(data);
    for (Match match in matches) {
      if (match.start == 0 && match.end == data.length) {
        return true;
      }
    }
    return false;
  }
}
