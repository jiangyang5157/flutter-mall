import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum UserType {
  Master,
  Normal,
  Anonymous,
}

String typeToString(UserType type) {
  return type.toString().split('.').last;
}

UserType stringToType(String s) {
  try {
    return UserType.values.firstWhere((element) => typeToString(element) == s);
  } on StateError {
    return null;
  }
}

class UserEntity extends Equatable {
  final UserType type;
  final String name;
  final String password;
  final String emailAddress;
  final String displayImagePath;

  UserEntity({
    @required this.type,
    @required this.name,
    @required this.password,
    @required this.emailAddress,
    @required this.displayImagePath,
  }) : super([type, name, password, emailAddress, displayImagePath]);

  @override
  String toString() {
    return '''
name: $type
name: $name
password: $password
emailAddress: $emailAddress
displayImagePath: $displayImagePath
''';
  }
}
