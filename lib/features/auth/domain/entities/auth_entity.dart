import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum AuthState {
  SignIn,
  SignUp,
}

String stateToString(AuthState state) {
  return state.toString().split('.').last;
}

AuthState stringToState(String s) {
  return AuthState.values.firstWhere((element) => stateToString(element) == s);
}

class AuthEntity extends Equatable {
  final AuthState state;

  AuthEntity({
    @required this.state,
  }) : super([state]);

  factory AuthEntity.fromString(String s) {
    return AuthEntity(state: stringToState(s));
  }

  @override
  String toString() {
    return stateToString(state);
  }
}
