import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class SignUpEntity extends Equatable {
  final String username;

  final String password;

  final String emailAddress;

  SignUpEntity({
    @required this.username,
    @required this.password,
    @required this.emailAddress,
  }) : super([username, password, emailAddress]);

  @override
  String toString() {
    return '''
username: $username
password: $password
emailAddress: $emailAddress
''';
  }
}
