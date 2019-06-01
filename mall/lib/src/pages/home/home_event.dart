import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  HomeEvent([List props = const []]) : super(props);
}

class HomeInitializedEvent extends HomeEvent {
  @override
  String toString() => 'HomeInitializedEvent';
}

class HomeSignedInEvent extends HomeEvent {
  @override
  String toString() => 'HomeSignedInEvent';
}

class HomeSignedOutEvent extends HomeEvent {
  @override
  String toString() => 'HomeSignedOutEvent';
}
