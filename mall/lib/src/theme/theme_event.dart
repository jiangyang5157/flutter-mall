import 'package:equatable/equatable.dart';

abstract class ThemeEvent extends Equatable {}

class LightThemeEvent extends ThemeEvent {
  @override
  String toString() => 'LightThemeEvent';
}

class DarkThemeEvent extends ThemeEvent {
  @override
  String toString() => 'DarkThemeEvent';
}
