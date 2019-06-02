import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

abstract class ThemeAppState extends Equatable {
  final ThemeData theme;

  ThemeAppState(this.theme) : super([theme]);
}

class ThemeAppLightState extends ThemeAppState {
  ThemeAppLightState() : super(ThemeData(brightness: Brightness.light));
}

class ThemeAppDarkState extends ThemeAppState {
  ThemeAppDarkState() : super(ThemeData(brightness: Brightness.dark));
}
