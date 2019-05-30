import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

import 'package:flutter/material.dart';

class AppLocalization {
  AppLocalization(this.locale, this.localizedValues);

  final Locale locale;

  final Map<String, dynamic> localizedValues;

  static AppLocalization of(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization);
  }

  String string(String id) => localizedValues[locale.languageCode][id];
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalization> {
  const AppLocalizationsDelegate();

  static final String localizedValuesPath = 'res/values/strings.json';

  static final List<String> supportedLanguageCodes = ['en'];

  @override
  bool isSupported(Locale locale) =>
      supportedLanguageCodes.contains(locale.languageCode);

  @override
  Future<AppLocalization> load(Locale locale) async {
    String localizedValuesJson =
        await rootBundle.loadString(localizedValuesPath);
    Map<String, dynamic> localizedValues = json.decode(localizedValuesJson);

    return AppLocalization(locale, localizedValues);
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
