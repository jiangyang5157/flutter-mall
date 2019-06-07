import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ThemeType { Light, Dark }

class ThemeModel extends ChangeNotifier {
  static const String _prefs_ThemeType = '_prefs_ThemeType';

  ThemeType _type;

  ThemeData get data {
    return _typeToData(_type);
  }

  ThemeData _typeToData(ThemeType type) {
    switch (type) {
      case ThemeType.Dark:
        return ThemeData(brightness: Brightness.dark);
      case ThemeType.Light:
        return ThemeData(brightness: Brightness.light);
    }
  }

  set type(ThemeType themeType) {
    _type = themeType;
    _saveType(_type);
    notifyListeners();
  }

  Future _initialize() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String themeTypeString = prefs.getString(_prefs_ThemeType);
    if (themeTypeString != null) {
      _type = _stringToType(themeTypeString);
    } else {
      _type = ThemeType.Light;
    }
    notifyListeners();
  }

  ThemeModel() {
    print('#### ThemeModel()');
    _initialize();
  }

  ThemeType _stringToType(String type) {
    return ThemeType.values
        .firstWhere((element) => _typeToString(element) == type);
  }

  String _typeToString(ThemeType type) {
    return type.toString().split('.').last;
  }

  Future _saveType(ThemeType themeType) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_prefs_ThemeType, _typeToString(_type));
  }
}
