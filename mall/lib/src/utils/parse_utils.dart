import 'package:parse_server_sdk/parse_server_sdk.dart';

import 'package:mall/src.dart';

ParseUtils parse = ParseUtils();

class ParseUtils {
  static final ParseUtils _singleton = ParseUtils._internal();

  factory ParseUtils() {
    return _singleton;
  }

  ParseUtils._internal();

  void initialize() {
    Parse().initialize(parseApplicationId, parseServerUrl,
        appName: parseApplicationName, masterKey: parseMasterKey, debug: true);
  }
}
