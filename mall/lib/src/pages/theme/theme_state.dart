import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

abstract class ThemeState extends Equatable {
  final ThemeData theme;

  ThemeState(this.theme) : super([theme]);
}

class LightThemeState extends ThemeState {
  LightThemeState() : super(ThemeData(brightness: Brightness.light));
}

class DarkThemeState extends ThemeState {
  DarkThemeState() : super(ThemeData(brightness: Brightness.dark));
}
