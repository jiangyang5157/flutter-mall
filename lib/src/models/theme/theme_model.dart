import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ThemeType { Light, Dark }

class ThemeModel extends ChangeNotifier {
  static const String _prefs_ThemeType = '_prefs_ThemeType';

  ThemeType _themeType;

  ThemeData get themeData {
    return _themeTypeToThemeData(_themeType);
  }

  ThemeData _themeTypeToThemeData(ThemeType type) {
    switch (type) {
      case ThemeType.Dark:
        return ThemeData(brightness: Brightness.dark);
      case ThemeType.Light:
        return ThemeData(brightness: Brightness.light);
    }
  }

  set themeType(ThemeType themeType) {
    _themeType = themeType;
    _saveThemeType(_themeType);
    notifyListeners();
  }

  Future _initialize() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String themeTypeString = prefs.getString(_prefs_ThemeType);
    if (themeTypeString != null) {
      _themeType = _stringToThemeType(themeTypeString);
    } else {
      _themeType = ThemeType.Light;
    }
    notifyListeners();
  }

  ThemeModel() {
    print('#### ThemeModel()');
    _initialize();
  }

  ThemeType _stringToThemeType(String type) {
    return ThemeType.values
        .firstWhere((element) => _themeTypeToString(element) == type);
  }

  String _themeTypeToString(ThemeType type) {
    return type.toString().split('.').last;
  }

  Future _saveThemeType(ThemeType themeType) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_prefs_ThemeType, _themeTypeToString(_themeType));
  }
}
