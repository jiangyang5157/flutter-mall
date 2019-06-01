import 'package:equatable/equatable.dart';

abstract class AppState extends Equatable {
  AppState([List props = const []]) : super([props]);
}

class AppUninitializedState extends AppState {
  @override
  String toString() => 'AppUninitializedState';
}

class AppInitializedState extends AppState {
  @override
  String toString() => 'AppInitializedState';
}

class AppUnauthenticatedState extends AppState {
  @override
  String toString() => 'AppUnauthenticatedState';
}

class AppAuthenticatedState extends AppState {
  @override
  String toString() => 'AppAuthenticatedState';
}
