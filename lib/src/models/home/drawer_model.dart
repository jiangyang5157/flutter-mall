import 'package:flutter/material.dart';

enum DrawerState {
  Menu,
  AccountDetails,
}

class DrawerModel extends ChangeNotifier {
  DrawerState _state;

  DrawerState get state => _state;

  set state(DrawerState state) {
    _state = state;
    notifyListeners();
  }

  DrawerModel() {
    print('#### DrawerModel()');
    state = DrawerState.Menu;
  }

  @override
  void dispose() {
    super.dispose();
    print('#### DrawerModel - dispose');
  }
}
