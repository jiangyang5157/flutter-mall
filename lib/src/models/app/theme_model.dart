import 'package:flutter/material.dart';
import 'package:mall/src/core/core.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ThemeType {
  Light,
  Dark,
}

class ThemeModel extends ChangeNotifier {
  static const String _prefs_ThemeType = '_prefs_ThemeType';

  ThemeType _type;

  ThemeType get type => _type;

  set type(ThemeType type) {
    _type = type;
    _saveType(type);
    notifyListeners();
  }

  ThemeModel() {
    print('#### ThemeModel()');
  }

  @override
  void dispose() {
    super.dispose();
    print('#### ThemeModel - dispose');
  }

  Future<void> init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String typeString = prefs.getString(_prefs_ThemeType);
    if (typeString == null) {
      type = ThemeType.Light;
    } else {
      type = _stringToType(typeString);
    }
  }

  Future<void> _saveType(ThemeType type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_prefs_ThemeType, _typeToString(type));
  }

  ThemeType _stringToType(String type) {
    return ThemeType.values
        .firstWhere((element) => _typeToString(element) == type);
  }

  String _typeToString(ThemeType type) {
    return type.toString().split('.').last;
  }

  ThemeData typeToData(BuildContext context, ThemeType type) {
    switch (type) {
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
      default:
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
    }
  }
}
