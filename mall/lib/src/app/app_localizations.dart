import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

import 'package:flutter/material.dart';

class AppLocalizations {
  AppLocalizations(this.locale, this.localizedValues);

  final Locale locale;

  Map<String, dynamic> localizedValues;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  String get hello {
    return localizedValues[locale.languageCode]['hello'];
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  static final String localizedValuesPath = 'res/values/strings.json';

  static final List<String> supportedLanguageCodes = ['en'];

  @override
  bool isSupported(Locale locale) =>
      supportedLanguageCodes.contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    String localizedValuesJson =
        await rootBundle.loadString(localizedValuesPath);
    Map<String, dynamic> localizedValues = json.decode(localizedValuesJson);

    return AppLocalizations(locale, localizedValues);
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
