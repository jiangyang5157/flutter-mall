import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:mall/src/app/app.dart';

class Translation {
  static Map<dynamic, dynamic> _strings;

  static Translation of(BuildContext context) {
    return Localizations.of<Translation>(context, Translation);
  }

  String string(String key) {
    if (_strings == null || _strings[key] == null) {
      return '';
    }
    return _strings[key];
  }

  static Future<Translation> load(String languageCode) async {
    if (languageCode == null) {
      return null;
    }
    Translation translation = Translation();
    String jsonContent =
        await rootBundle.loadString("res/values/strings_$languageCode.json");
    _strings = json.decode(jsonContent);
    return translation;
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<Translation> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      config.supportedLanguageCodes.contains(locale.languageCode);

  @override
  Future<Translation> load(Locale locale) =>
      Translation.load(locale.languageCode);

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}

class OverriddenLocalizationsDelegate
    extends LocalizationsDelegate<Translation> {
  final String _languageCode;

  const OverriddenLocalizationsDelegate(this._languageCode);

  @override
  bool isSupported(Locale locale) =>
      _languageCode != null &&
      config.supportedLanguageCodes.contains(_languageCode);

  @override
  Future<Translation> load(Locale locale) => Translation.load(_languageCode);

  @override
  bool shouldReload(LocalizationsDelegate<Translation> old) => true;
}
