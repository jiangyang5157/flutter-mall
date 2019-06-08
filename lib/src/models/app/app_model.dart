import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:rxdart/rxdart.dart';

import 'package:mall/src/core/core.dart';

enum AppState { Initialized, UpdateRequired, DownTime }

class AppModel extends ChangeNotifier {
  BehaviorSubject<AppState> _stateController = BehaviorSubject<AppState>();

  Stream<AppState> get stateOut => _stateController.stream;

  Sink<AppState> get stateIn => _stateController.sink;

  AppState get state => _stateController.value;

  set state(AppState appState) {
    stateIn.add(appState);
  }

  @override
  void dispose() {
    super.dispose();
    print('#### AppModel - dispose');
    _stateController.close();
  }

  AppModel() {
    print('#### AppModel()');
    stateOut.listen(_setState);
    _init();
  }

  void _setState(AppState appState) {
    notifyListeners();
  }

  Future _init() async {
    Parse().initialize(parseApplicationId, parseServerUrl,
        appName: parseApplicationName, masterKey: parseMasterKey, debug: true);
    Parse().healthCheck();

    state = AppState.Initialized;
  }
}
