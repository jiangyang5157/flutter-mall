import 'package:equatable/equatable.dart';

abstract class AppState extends Equatable {
  AppState([List props = const []]) : super([props]);
}

class AppUninitializedState extends AppState {}

class AppInitializedState extends AppState {}

class AppUnauthenticatedState extends AppState {}

class AppAuthenticatedState extends AppState {}
