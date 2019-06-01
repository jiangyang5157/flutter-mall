import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:bloc/bloc.dart';

import 'package:mall/src.dart';

void main() {
  BlocSupervisor.delegate = BlocSupervisorDelegate();

  Parse().initialize(parseApplicationId, parseServerUrl,
      appName: parseApplicationName, masterKey: parseMasterKey, debug: true);

  runApp(ApplicationPage());
}
