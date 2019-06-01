import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

abstract class AppState extends Equatable {
  AppState([List props = const []]) : super([props]);
}

class AppLightThemeState extends AppState {
  static final ThemeData theme = ThemeData(brightness: Brightness.light);

  AppLightThemeState() : super([theme]);

  @override
  String toString() => 'AppLightThemeState';
}

class AppDarkThemeState extends AppState {
  static final ThemeData theme = ThemeData(brightness: Brightness.dark);

  AppDarkThemeState() : super([theme]);

  @override
  String toString() => 'AppDarkThemeState';
}
