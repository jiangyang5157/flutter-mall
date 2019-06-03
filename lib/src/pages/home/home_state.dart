import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  HomeState([List props = const []]) : super([props]);
}

class InitialHomeState extends HomeState {}

class SignOutStartState extends HomeState {}

class SignOutFinishState extends HomeState {}
