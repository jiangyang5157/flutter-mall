import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';

class Localization {
  Localization(this._locale, this._localizedValues);

  final Locale _locale;

  final Map<String, dynamic> _localizedValues;

  static Localization of(BuildContext context) {
    return Localizations.of<Localization>(context, Localization);
  }

  String string(String id) => _localizedValues[_locale.languageCode][id];
}

class AppLocalizationsDelegate extends LocalizationsDelegate<Localization> {
  const AppLocalizationsDelegate();

  static const String _localizedValuesPath = 'res/values/strings.json';

  static const List<String> _supportedLanguageCodes = ['en'];

  static List<String> get supportedLanguageCodes => _supportedLanguageCodes;

  @override
  bool isSupported(Locale locale) =>
      supportedLanguageCodes.contains(locale.languageCode);

  @override
  Future<Localization> load(Locale locale) async {
    String localizedValuesJson =
        await rootBundle.loadString(_localizedValuesPath);
    Map<String, dynamic> localizedValues = json.decode(localizedValuesJson);

    return Localization(locale, localizedValues);
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
