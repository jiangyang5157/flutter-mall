import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rxdart/rxdart.dart';

import 'blocs.dart';

class AppBloc implements BlocBase {
  static const String _prefsKey_bool_darkTheme = 'darkTheme';

  BehaviorSubject<bool> _darkThemeController = BehaviorSubject<bool>();

  Stream<bool> get outDarkTheme => _darkThemeController.stream;

  Sink<bool> get inDarkTheme => _darkThemeController.sink;

  AppBloc() {
    outDarkTheme.listen(_setDarkTheme);
    _loadDarkTheme();
  }

  Future<void> _loadDarkTheme() async {
    bool darkTheme = await _getDarkTheme();
    inDarkTheme.add(darkTheme);
  }

  Future<bool> _getDarkTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_prefsKey_bool_darkTheme) ?? false;
  }

  Future<void> _setDarkTheme(bool data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_prefsKey_bool_darkTheme, data);
  }

  @override
  void dispose() {
    _darkThemeController.close();
  }
}
