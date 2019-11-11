import 'package:flutter/material.dart';
import 'package:mall/src/core/core.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

enum InitState {
  Start,
  Finish,
}

class InitModel extends ChangeNotifier {
  InitState _state;

  InitState get state => _state;

  set state(InitState state) {
    _state = state;
    notifyListeners();
  }

  InitModel() {
    print('#### InitModel()');
  }

  @override
  void dispose() {
    super.dispose();
    print('#### InitModel - dispose');
  }

  Future<void> init() async {
    state = InitState.Start;

    Parse().initialize(parseApplicationId, parseServerUrl,
        appName: parseApplicationName,
        masterKey: parseMasterKey,
        autoSendSessionId: true,
        coreStore: await CoreStoreSembastImp.getInstance(),
        debug: true);

    state = InitState.Finish;
  }
}
