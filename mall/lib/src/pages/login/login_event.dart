import 'package:equatable/equatable.dart';

import 'package:mall/src/parse/parse.dart';

abstract class LoginEvent extends Equatable {
  LoginEvent([List props = const []]) : super(props);
}

class SignUpEvent extends LoginEvent {
  final String username;
  final String password;
  final String emailAddress;

  SignUpEvent(this.username, this.password, this.emailAddress)
      : super([username, password, emailAddress]);
}

class SignInEvent extends LoginEvent {
  final String username;
  final String password;

  SignInEvent(this.username, this.password) : super([username, password]);
}

class CurrentUserFoundEvent extends LoginEvent {
  final User user;

  CurrentUserFoundEvent(this.user) : super([user]);
}
