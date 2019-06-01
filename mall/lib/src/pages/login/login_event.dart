import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  LoginEvent([List props = const []]) : super(props);
}

class SignUpEvent extends LoginEvent {
  final String username;
  final String password;
  final String emailAddress;

  SignUpEvent(this.username, this.password, this.emailAddress)
      : super([username, password, emailAddress]);

  @override
  String toString() =>
      'SignUpEvent: username=$username, password=$password, emailAddress=$emailAddress';
}

class SignInEvent extends LoginEvent {
  final String username;
  final String password;

  SignInEvent(this.username, this.password) : super([username, password]);

  @override
  String toString() => 'SignInEvent: username=$username, password=$password';
}
