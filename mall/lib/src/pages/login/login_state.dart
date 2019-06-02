import 'package:equatable/equatable.dart';

import 'package:mall/src/parse/parse.dart';

abstract class LoginState extends Equatable {
  LoginState([List props = const []]) : super(props);
}

class LoginInitialState extends LoginState {}

class LoginStartState extends LoginState {}

class LoginCurrentUserStartState extends LoginState {
  final User user;

  LoginCurrentUserStartState(this.user) : super([user]);
}

class LoginSuccessState extends LoginState {}

class LoginFailureState extends LoginState {
  final String error;

  LoginFailureState([this.error]) : super([error]);
}
