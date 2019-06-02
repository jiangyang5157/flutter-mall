import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

abstract class ThemeAppState extends Equatable {
  final ThemeData theme;

  ThemeAppState(this.theme) : super([theme]);
}

class LightAppThemeState extends ThemeAppState {
  LightAppThemeState() : super(ThemeData(brightness: Brightness.light));
}

class DarkAppThemeState extends ThemeAppState {
  DarkAppThemeState() : super(ThemeData(brightness: Brightness.dark));
}
