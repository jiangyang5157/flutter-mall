import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:mall/src.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  static const String _prefs_IsDarkTheme = '_prefs_IsDarkTheme';
  static const bool _prefs_IsDarkTheme_default = false;

  Future<bool> _isDarkTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_prefs_IsDarkTheme) ?? _prefs_IsDarkTheme_default;
  }

  Future<void> _setIsDarkTheme(bool isDarkTheme) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_prefs_IsDarkTheme, isDarkTheme);
  }

  Future<void> _sync() async {
    if (await _isDarkTheme()) {
      dispatch(DarkThemeEvent());
    } else {
      dispatch(LightThemeEvent());
    }
  }

  @override
  ThemeState get initialState {
    _sync();
    return _prefs_IsDarkTheme_default ? DarkThemeState() : LightThemeState();
  }

  @override
  Stream<ThemeState> mapEventToState(ThemeEvent event) async* {
    if (event is DarkThemeEvent) {
      _setIsDarkTheme(true);
      yield DarkThemeState();
    }

    if (event is LightThemeEvent) {
      _setIsDarkTheme(false);
      yield LightThemeState();
    }
  }
}
