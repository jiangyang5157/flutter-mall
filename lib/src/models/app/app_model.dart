import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

import 'package:mall/src/core/core.dart';

enum AppState {
  Initialized,
}

class AppModel extends ChangeNotifier {
  AppState _state;

  AppState get state => _state;

  set state(AppState state) {
    _state = state;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    print('#### AppModel - dispose');
  }

  AppModel() {
    print('#### AppModel()');
  }

  Future<void> init() async {
    Parse().initialize(parseApplicationId, parseServerUrl,
        appName: parseApplicationName, masterKey: parseMasterKey, debug: true);

    state = AppState.Initialized;
  }
}
