import 'package:flutter/material.dart';
import 'package:mall/src/core/core.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ThemeType {
  Light,
  Dark,
}

class AppModel extends ChangeNotifier {
  static const String _prefs_ThemeType = '_prefs_ThemeType';

  ThemeType _themeType;

  ThemeType get themeType => _themeType;

  set themeType(ThemeType themeType) {
    _themeType = themeType;
    _saveThemeType(themeType);
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    print('#### AppModel - dispose');
  }

  AppModel() {
    print('#### AppModel()');
  }

  Future<void> init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String typeString = prefs.getString(_prefs_ThemeType);
    if (typeString == null) {
      themeType = ThemeType.Light;
    } else {
      themeType = _stringToThemeType(typeString);
    }
  }

  Future<void> _saveThemeType(ThemeType themeType) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_prefs_ThemeType, _themeTypeToString(themeType));
  }

  ThemeType _stringToThemeType(String themeType) {
    return ThemeType.values
        .firstWhere((element) => _themeTypeToString(element) == themeType);
  }

  String _themeTypeToString(ThemeType themeType) {
    return themeType.toString().split('.').last;
  }

  ThemeData themeTypeToData(BuildContext context, ThemeType themeType) {
    switch (themeType) {
      case ThemeType.Dark:
        return ThemeData.dark().copyWith(
          primaryColor: Colors.green,
          accentColor: Colors.greenAccent,
          errorColor: Colors.greenAccent,
          buttonTheme: ButtonTheme.of(context).copyWith(
            textTheme: ButtonTextTheme.primary,
            buttonColor: Colors.green,
            minWidth: btnMinWidth,
            height: btnHeight,
          ),
        );
      case ThemeType.Light:
        return ThemeData.light().copyWith(
          primaryColor: Colors.blue,
          accentColor: Colors.blueAccent,
          errorColor: Colors.blueAccent,
          buttonTheme: ButtonTheme.of(context).copyWith(
            textTheme: ButtonTextTheme.primary,
            buttonColor: Colors.blue,
            minWidth: btnMinWidth,
            height: btnHeight,
          ),
        );
      default:
        throw ("$themeType is not recognized as an ThemeType");
    }
  }
}
