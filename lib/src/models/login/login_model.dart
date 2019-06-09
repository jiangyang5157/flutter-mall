import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

enum LoginState { SignIn, SignUp }

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
    _stateController.close();
    super.dispose();
    print('#### LoginModel - dispose');
  }

  LoginModel() {
    print('#### LoginModel()');
    stateOut.listen(_setState);
    _init();
  }

  void _init() {
    state = LoginState.SignIn;
  }

  void _setState(LoginState appState) {
    notifyListeners();
  }
}
