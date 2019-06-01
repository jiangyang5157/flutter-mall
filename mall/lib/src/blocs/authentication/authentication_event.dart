import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  AuthenticationEvent([List props = const []]) : super(props);
}

class AuthenticationErrorEvent extends AuthenticationEvent {
  final String message;

  AuthenticationErrorEvent([this.message]) : super([message]);

  @override
  String toString() => 'AuthenticationErrorEvent';
}

class AuthenticationSignUpEvent extends AuthenticationEvent {
  final String username;
  final String password;
  final String emailAddress;

  AuthenticationSignUpEvent(this.username, this.password, this.emailAddress)
      : super([username, password, emailAddress]);

  @override
  String toString() => 'AuthenticationSignUpEvent';
}

class AuthenticationSignedUpEvent extends AuthenticationEvent {
  @override
  String toString() => 'AuthenticationSignedUpEvent';
}

class AuthenticationSignInEvent extends AuthenticationEvent {
  final String username;
  final String password;

  AuthenticationSignInEvent(this.username, this.password)
      : super([username, password]);

  @override
  String toString() => 'AuthenticationSignInEvent';
}

class AuthenticationSignedInEvent extends AuthenticationEvent {
  @override
  String toString() => 'AuthenticationSignedInEvent';
}

class AuthenticationSignInCurrentUserEvent extends AuthenticationEvent {
  @override
  String toString() => 'AuthenticationSignInCurrentUserEvent';
}

class AuthenticationSignedInCurrentUserEvent extends AuthenticationEvent {
  @override
  String toString() => 'AuthenticationSignedInCurrentUserEvent';
}

class AuthenticationSignOutEvent extends AuthenticationEvent {
  @override
  String toString() => 'AuthenticationSignOutEvent';
}

class AuthenticationSignedOutEvent extends AuthenticationEvent {
  @override
  String toString() => 'AuthenticationSignedOutEvent';
}
