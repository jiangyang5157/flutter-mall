import 'package:equatable/equatable.dart';

abstract class AppEvent extends Equatable {
  AppEvent([List props = const []]) : super([props]);
}

class AppLightThemeEvent extends AppEvent {
  @override
  String toString() => 'AppLightThemeEvent';
}

class AppDarkThemeEvent extends AppEvent {
  @override
  String toString() => 'AppDarkThemeEvent';
}
