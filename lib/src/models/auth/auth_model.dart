import 'package:flutter/material.dart';

enum AuthState { Unauthenticated, Authenticated }

class AuthModel extends ChangeNotifier {
  AuthState _state;

  AuthState get state => _state;

  set state(AuthState authState) {
    _state = authState;
    notifyListeners();
  }

  AuthModel() {
    print('#### AuthModel()');
    state = AuthState.Unauthenticated;
  }
}
