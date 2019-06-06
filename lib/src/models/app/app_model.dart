import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

import 'package:mall/src/parse/parse.dart';

class AppModel extends ChangeNotifier {
  bool _initialized;

  bool get initialized => _initialized;

  void _setInitialized(bool initialized) {
    _initialized = initialized;
    notifyListeners();
  }

  AppModel() {
    initialize();
  }

  Future initialize() async {
    Parse().initialize(parseApplicationId, parseServerUrl,
        appName: parseApplicationName, masterKey: parseMasterKey, debug: true);
    Parse().healthCheck();

    _setInitialized(true);
  }
}
