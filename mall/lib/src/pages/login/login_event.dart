import 'package:equatable/equatable.dart';

import 'package:mall/src/parse/parse.dart';

abstract class LoginEvent extends Equatable {
  LoginEvent([List props = const []]) : super(props);
}

class LoginSignUpEvent extends LoginEvent {
  final String username;
  final String password;
  final String emailAddress;

  LoginSignUpEvent(this.username, this.password, this.emailAddress)
      : super([username, password, emailAddress]);
}

class LoginSignInEvent extends LoginEvent {
  final String username;
  final String password;

  LoginSignInEvent(this.username, this.password) : super([username, password]);
}

class LoginSignInCurrentUserEvent extends LoginEvent {
  final User user;

  LoginSignInCurrentUserEvent(this.user) : super([user]);
}
