import 'package:equatable/equatable.dart';

abstract class AppEvent extends Equatable {
  AppEvent([List props = const []]) : super(props);
}

class AppInitializedEvent extends AppEvent {
  @override
  String toString() => 'AppInitializedEvent';
}

class AppSignedInEvent extends AppEvent {
  @override
  String toString() => 'AppSignedInEvent';
}

class AppSignedOutEvent extends AppEvent {
  @override
  String toString() => 'AppSignedOutEvent';
}
