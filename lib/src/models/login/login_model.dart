import 'package:flutter/material.dart';

enum LoginState {
  SignIn,
  SignUp,
}

class LoginModel extends ChangeNotifier {
  LoginState _state;

  LoginState get state => _state;

  set state(LoginState state) {
    _state = state;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    print('#### LoginModel - dispose');
  }

  LoginModel() {
    print('#### LoginModel()');
    state = LoginState.SignIn;
  }
}
