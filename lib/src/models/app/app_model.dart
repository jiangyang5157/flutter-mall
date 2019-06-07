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

  set state(AppState state) {
    stateIn.add(state);
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
    _initialize();
  }

  void _setState(AppState state) {
    notifyListeners();
  }

  Future _initialize() async {
    Parse().initialize(parseApplicationId, parseServerUrl,
        appName: parseApplicationName, masterKey: parseMasterKey, debug: true);
    Parse().healthCheck();

    state = AppState.Initialized;
  }
}
