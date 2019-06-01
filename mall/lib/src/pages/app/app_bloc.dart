import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:mall/src/pages/app/app.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  static const String _prefs_IsDarkTheme = '_prefs_IsDarkTheme';
  static const bool _prefs_IsDarkTheme_default = false;

  Future<void> initialize() async {
    if (await _isDarkTheme()) {
      dispatch(AppDarkThemeEvent());
    } else {
      dispatch(AppLightThemeEvent());
    }
  }

  Future<bool> _isDarkTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_prefs_IsDarkTheme) ?? _prefs_IsDarkTheme_default;
  }

  Future<void> _setIsDarkTheme(bool isDarkTheme) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_prefs_IsDarkTheme, isDarkTheme);
  }

  @override
  AppState get initialState {
    initialize();
    return _prefs_IsDarkTheme_default
        ? AppDarkThemeState()
        : AppLightThemeState();
  }

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is AppDarkThemeEvent) {
      await _setIsDarkTheme(true);
      yield AppDarkThemeState();
    }

    if (event is AppLightThemeEvent) {
      await _setIsDarkTheme(false);
      yield AppLightThemeState();
    }
  }
}
