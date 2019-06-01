import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {
  AuthenticationState([List props = const []]) : super(props);
}

class AuthenticationErrorState extends AuthenticationState {
  final String message;

  AuthenticationErrorState([this.message]) : super([message]);

  @override
  String toString() => 'AuthenticationErrorState';
}

class AuthenticationUnauthenticatedState extends AuthenticationState {
  @override
  String toString() => 'AuthenticationUnauthenticatedState';
}

class AuthenticationStartState extends AuthenticationState {
  @override
  String toString() => 'AuthenticationStartState';
}

class AuthenticationAuthenticatedState extends AuthenticationState {
  @override
  String toString() => 'AuthenticationAuthenticatedState';
}
