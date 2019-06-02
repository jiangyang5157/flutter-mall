import 'package:equatable/equatable.dart';

abstract class AppEvent extends Equatable {
  AppEvent([List props = const []]) : super(props);
}

class AppInitializedEvent extends AppEvent {}

class AppSignedInEvent extends AppEvent {}

class AppSignedOutEvent extends AppEvent {}
