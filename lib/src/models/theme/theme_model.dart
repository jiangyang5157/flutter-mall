import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rxdart/rxdart.dart';

enum ThemeType { Light, Dark }

class ThemeModel extends ChangeNotifier {
  static const String _prefs_ThemeType = '_prefs_ThemeType';

  BehaviorSubject<ThemeType> _typeController =
      BehaviorSubject<ThemeType>.seeded(ThemeType.Light);

  Stream<ThemeType> get typeOut => _typeController.stream;

  Sink<ThemeType> get typeIn => _typeController.sink;

  ThemeType get type => _typeController.value;

  set type(ThemeType type) {
    typeIn.add(type);
  }

  @override
  void dispose() {
    super.dispose();
    print('#### ThemeModel - dispose');
    _typeController.close();
  }

  ThemeModel() {
    print('#### ThemeModel()');
    typeOut.listen(_setType);
    _initialize();
  }

  void _setType(ThemeType type) {
    _saveType(type);
    notifyListeners();
  }

  Future _initialize() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String typeString = prefs.getString(_prefs_ThemeType);
    if (typeString != null) {
      type = _stringToType(typeString);
    }
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

  ThemeData typeToData(ThemeType type) {
    switch (type) {
      case ThemeType.Dark:
        return ThemeData(brightness: Brightness.dark);
      case ThemeType.Light:
        return ThemeData(brightness: Brightness.light);
    }
  }
}
