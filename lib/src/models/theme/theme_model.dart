import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rxdart/rxdart.dart';

import 'package:mall/src/core/core.dart';

enum ThemeType {
  Light,
  Dark,
}

class ThemeModel extends ChangeNotifier {
  static const String _prefs_ThemeType = '_prefs_ThemeType';

  BehaviorSubject<ThemeType> _typeController =
      BehaviorSubject<ThemeType>.seeded(ThemeType.Light);

  Stream<ThemeType> get typeOut => _typeController.stream;

  Sink<ThemeType> get typeIn => _typeController.sink;

  ThemeType get type => _typeController.value;

  set type(ThemeType themeType) {
    typeIn.add(themeType);
  }

  @override
  void dispose() {
    _typeController.close();
    super.dispose();
    print('#### ThemeModel - dispose');
  }

  ThemeModel() {
    print('#### ThemeModel()');
    typeOut.listen(_setType);
    _init();
  }

  Future _init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String typeString = prefs.getString(_prefs_ThemeType);
    if (typeString != null) {
      type = _stringToType(typeString);
    }
  }

  void _setType(ThemeType themeType) {
    _saveType(themeType);
    notifyListeners();
  }

  Future _saveType(ThemeType type) async {
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
    }
  }
}
