import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class SignInEntity extends Equatable {
  final String username;

  final String password;

  final bool obscurePassword;

  SignInEntity({
    @required this.username,
    @required this.password,
    @required this.obscurePassword,
  }) : super([username, password, obscurePassword]);

  @override
  String toString() {
    return '''
username: $username
password: $password
obscurePassword: $obscurePassword
''';
  }
}
