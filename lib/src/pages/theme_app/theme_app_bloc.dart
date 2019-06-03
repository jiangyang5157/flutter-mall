import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:mall/src/pages/theme_app/theme_app.dart';

class ThemeAppBloc extends Bloc<ThemeAppEvent, ThemeAppState> {
  static const String _prefs_IsDarkTheme = '_prefs_IsDarkTheme';
  static const bool _prefs_IsDarkTheme_default = false;

  Future initialize() async {
    if (await _isDarkTheme()) {
      dispatch(DarkAppThemeEvent());
    } else {
      dispatch(LightAppThemeEvent());
    }
  }

  Future<bool> _isDarkTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_prefs_IsDarkTheme) ?? _prefs_IsDarkTheme_default;
  }

  Future _setIsDarkTheme(bool isDarkTheme) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_prefs_IsDarkTheme, isDarkTheme);
  }

  @override
  ThemeAppState get initialState {
    initialize();
    return _prefs_IsDarkTheme_default
        ? DarkAppThemeState()
        : LightAppThemeState();
  }

  @override
  Stream<ThemeAppState> mapEventToState(ThemeAppEvent event) async* {
    if (event is DarkAppThemeEvent) {
      await _setIsDarkTheme(true);
      yield DarkAppThemeState();
    }

    if (event is LightAppThemeEvent) {
      await _setIsDarkTheme(false);
      yield LightAppThemeState();
    }
  }
}
