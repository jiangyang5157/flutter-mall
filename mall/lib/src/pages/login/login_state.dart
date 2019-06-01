import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  LoginState([List props = const []]) : super(props);
}

class LoginInitialState extends LoginState {
  @override
  String toString() => 'LoginInitialState';
}

class LoginStartState extends LoginState {
  @override
  String toString() => 'LoginStartState';
}

class LoginSuccessState extends LoginState {
  @override
  String toString() => 'LoginSuccessState';
}

class LoginFailureState extends LoginState {
  final String error;

  LoginFailureState([this.error]) : super([error]);

  @override
  String toString() => 'LoginFailureState: error=$error';
}
