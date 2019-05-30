import 'dart:async';
import 'package:flutter/foundation.dart' show SynchronousFuture;

import 'package:flutter/material.dart';

class AppLocalizations {
  AppLocalizations(this.locale);

  static final List<String> supportedLanguageCodes = ['en'];

  final Locale locale;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'hello': 'Hello!',
    },
  };

  String get hello {
    return _localizedValues[locale.languageCode]['hello'];
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => AppLocalizations.supportedLanguageCodes.contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
