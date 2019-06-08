import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:rxdart/rxdart.dart';

import 'package:mall/src/core/core.dart';

enum LoginState { SignIn, SignUp, Login }

class LoginModel extends ChangeNotifier {
  BehaviorSubject<LoginState> _stateController = BehaviorSubject<LoginState>();

  Stream<LoginState> get stateOut => _stateController.stream;

  Sink<LoginState> get stateIn => _stateController.sink;

  LoginState get state => _stateController.value;

  set state(LoginState appState) {
    stateIn.add(appState);
  }

  @override
  void dispose() {
    super.dispose();
    print('#### LoginModel - dispose');
    _stateController.close();
  }

  LoginModel() {
    print('#### LoginModel()');
    stateOut.listen(_setState);
    _init();
  }

  void _setState(LoginState appState) {
    notifyListeners();
  }

  Future _init() async {
    state = LoginState.SignIn;
  }
}
