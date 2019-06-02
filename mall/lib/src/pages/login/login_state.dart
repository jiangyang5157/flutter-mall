import 'package:equatable/equatable.dart';

import 'package:mall/src/parse/parse.dart';

abstract class LoginState extends Equatable {
  LoginState([List props = const []]) : super(props);
}

class InitialLoginState extends LoginState {
  final User user;

  InitialLoginState([this.user]) : super([user]);
}

class StartSignInState extends LoginState {}

class StartSignUpState extends LoginState {}

class SignInSuccessState extends LoginState {}

class SignUpSuccessState extends LoginState {}

class SignInFailureState extends LoginState {
  final String error;

  SignInFailureState([this.error]) : super([error]);
}

class SignUpFailureState extends LoginState {
  final String error;

  SignUpFailureState([this.error]) : super([error]);
}
