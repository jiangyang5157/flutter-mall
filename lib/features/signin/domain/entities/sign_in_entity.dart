import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class SignInEntity extends Equatable {
  final String username;

  final String password;

  SignInEntity({
    @required this.username,
    @required this.password,
  }) : super([username, password]);

  @override
  String toString() {
    return '''
username: $username
password: $password
''';
  }
}
