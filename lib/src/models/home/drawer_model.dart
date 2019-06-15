import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

enum DrawerState {
  Menu,
  AccountDetails,
}

class DrawerModel extends ChangeNotifier {
  BehaviorSubject<DrawerState> _stateController =
      BehaviorSubject<DrawerState>();

  Stream<DrawerState> get stateOut => _stateController.stream;

  Sink<DrawerState> get stateIn => _stateController.sink;

  DrawerState get state => _stateController.value;

  set state(DrawerState appState) {
    stateIn.add(appState);
  }

  @override
  void dispose() {
    _stateController.close();
    super.dispose();
    print('#### DrawerModel - dispose');
  }

  DrawerModel() {
    print('#### DrawerModel()');
    stateOut.listen(_setState);
    _init();
  }

  void _init() {
    state = DrawerState.Menu;
  }

  void _setState(DrawerState appState) {
    notifyListeners();
  }
}
