import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  LoginState([List props = const []]) : super(props);
}

class LoginInitialState extends LoginState {}

class LoginStartState extends LoginState {}

class LoginSuccessState extends LoginState {}

class LoginFailureState extends LoginState {
  final String error;

  LoginFailureState([this.error]) : super([error]);

  @override
  String toString() => 'LoginFailureState: error=$error';
}
