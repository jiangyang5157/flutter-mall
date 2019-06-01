import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  HomeState([List props = const []]) : super([props]);
}

class HomeUninitializedState extends HomeState {
  @override
  String toString() => 'HomeUninitializedState';
}

class HomeInitializedState extends HomeState {
  @override
  String toString() => 'HomeInitializedState';
}

class HomeUnauthenticatedState extends HomeState {
  @override
  String toString() => 'HomeUnauthenticatedState';
}

class HomeAuthenticatedState extends HomeState {
  @override
  String toString() => 'HomeAuthenticatedState';
}
