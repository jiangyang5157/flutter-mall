import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

import 'package:mall/src/parse/parse.dart';

enum AppState { Uninitialized, Initialized }

class AppModel extends ChangeNotifier {
  AppState _state;

  AppState get state => _state;

  void _setState(AppState state) {
    _state = state;
    notifyListeners();
  }

  Future _initialize() async {
    Parse().initialize(parseApplicationId, parseServerUrl,
        appName: parseApplicationName, masterKey: parseMasterKey, debug: true);
    Parse().healthCheck();

    _setState(AppState.Initialized);
  }

  AppModel() {
    print('#### AppModel()');
    _initialize();
  }
}
