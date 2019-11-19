import 'package:flutter/material.dart';

enum AuthState {
  SignIn,
  SignUp,
}

class AuthModel extends ChangeNotifier {
  AuthState _state;

  AuthState get state => _state;

  set state(AuthState state) {
    _state = state;
    notifyListeners();
  }

  AuthModel() {
    print('#### AuthModel()');
    state = AuthState.SignIn;
  }

  @override
  void dispose() {
    super.dispose();
    print('#### AuthModel - dispose');
  }
}