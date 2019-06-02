import 'package:equatable/equatable.dart';

abstract class ThemeAppEvent extends Equatable {}

class ThemeAppLightEvent extends ThemeAppEvent {}

class ThemeAppDarkEvent extends ThemeAppEvent {}
