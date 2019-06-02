import 'package:equatable/equatable.dart';

abstract class ThemeEvent extends Equatable {}

class LightThemeEvent extends ThemeEvent {}

class DarkThemeEvent extends ThemeEvent {}
