import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  HomeState([List props = const []]) : super([props]);
}

class HomeInitialState extends HomeState {}

class HomeLogoutStartState extends HomeState {}

class HomeLogoutCompletedState extends HomeState {}
