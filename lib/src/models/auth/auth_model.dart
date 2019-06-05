import 'package:flutter/material.dart';

enum AuthState { Unauthenticated, Authenticated }

class AuthModel extends ChangeNotifier {
  AuthState _authState;

  AuthState get authState => _authState;

  set authState(AuthState authState) {
    _authState = authState;
    notifyListeners();
  }

  AuthModel() {
    authState = AuthState.Unauthenticated;
  }
}
