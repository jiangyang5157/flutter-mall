import 'package:equatable/equatable.dart';

abstract class ThemeAppEvent extends Equatable {}

class LightAppThemeEvent extends ThemeAppEvent {}

class DarkAppThemeEvent extends ThemeAppEvent {}
