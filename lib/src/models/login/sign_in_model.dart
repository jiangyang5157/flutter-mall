import 'package:flutter/material.dart';

class SignInModel extends ChangeNotifier {
  @override
  void dispose() {
    super.dispose();
    print('#### SignInModel - dispose');
  }

  String _username;

  String get username => _username;

  set username(String username) {
    _username = username;
    notifyListeners();
  }

  String _password;

  String get password => _password;

  set password(String password) {
    _password = password;
    notifyListeners();
  }

  SignInModel() {
    print('#### SignInModel()');
    _init();
  }

  void _init() {
    username = '';
    password = '';
  }
}
