import 'package:flutter/material.dart';

typedef void LanguageCodeChangeCallback(String languageCode);

typedef void ThemeDataChangeCallback(ThemeData themeData);

class Config {
  static final Config _config = Config._internal();

  factory Config() {
    return _config;
  }

  Config._internal();

  final List<String> supportedLanguageCodes = ["en", "zh"];

  Iterable<Locale> supportedLanguageLocales() => supportedLanguageCodes
      .map<Locale>((languageCode) => Locale(languageCode));

  LanguageCodeChangeCallback onLanguageCodeChanged;

  ThemeDataChangeCallback onThemeDataChanged;
}

Config config = Config();
