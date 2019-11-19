import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class SignUpEntity extends Equatable {
  final String username;

  final String password;

  final String repeatPassword;

  final String emailAddress;

  final bool obscurePassword;

  SignUpEntity({
    @required this.username,
    @required this.password,
    @required this.repeatPassword,
    @required this.emailAddress,
    @required this.obscurePassword,
  }) : super([
          username,
          password,
          repeatPassword,
          emailAddress,
          obscurePassword
        ]);

  @override
  String toString() {
    return '''
username: $username
password: $password
repeatPassword: $repeatPassword
emailAddress: $emailAddress
obscurePassword: $obscurePassword
''';
  }
}
