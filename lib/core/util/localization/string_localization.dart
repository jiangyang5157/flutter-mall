import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:mall/core/constant.dart';

String string(BuildContext context, String id) =>
    StringLocalization.of(context).string(id) ?? null;

class StringLocalization {
  StringLocalization(this._locale, this._localizedValues);

  final Locale _locale;

  final Map<String, dynamic> _localizedValues;

  static StringLocalization of(BuildContext context) {
    return Localizations.of<StringLocalization>(context, StringLocalization);
  }

  String string(String id) => _localizedValues[_locale.languageCode][id];
}

class StringDelegate extends LocalizationsDelegate<StringLocalization> {
  const StringDelegate();

  static const String _localizedValuesPath = localizedValuesPath;

  static const List<String> _supportedLanguageCodes = [englishLanguageCode];

  static List<String> get supportedLanguageCodes => _supportedLanguageCodes;

  @override
  bool isSupported(Locale locale) =>
      supportedLanguageCodes.contains(locale.languageCode);

  @override
  Future<StringLocalization> load(Locale locale) async {
    String localizedValuesJson =
        await rootBundle.loadString(_localizedValuesPath);
    Map<String, dynamic> localizedValues = json.decode(localizedValuesJson);

    return StringLocalization(locale, localizedValues);
  }

  @override
  bool shouldReload(StringDelegate old) => false;
}
