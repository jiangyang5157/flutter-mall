import 'package:flutter/material.dart';
import 'package:mall/src/core/core.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

enum SplashState {
  Initialized,
}

class SplashModel extends ChangeNotifier {
  SplashState _state;

  SplashState get state => _state;

  set state(SplashState state) {
    _state = state;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    print('#### SplashModel - dispose');
  }

  SplashModel() {
    print('#### SplashModel()');
  }

  Future<void> init() async {
    Parse().initialize(parseApplicationId, parseServerUrl,
        appName: parseApplicationName,
        masterKey: parseMasterKey,
        autoSendSessionId: true,
        coreStore: await CoreStoreSembastImp.getInstance(),
        debug: true);

    state = SplashState.Initialized;
  }
}
