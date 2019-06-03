import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import 'package:mall/src/pages/pages.dart';

class Navigation {
  static final Navigation _instance = Navigation._internal();

  factory Navigation() {
    return _instance;
  }

  Router _router;

  Router get router => _router;

  Navigation._internal() {
    _router = Router()
      ..define('/', handler: Handler(
          handlerFunc: (BuildContext context, Map<String, dynamic> params) {
        return AppPage();
      }))
      ..define('TestPage', handler: Handler(
          handlerFunc: (BuildContext context, Map<String, dynamic> params) {
        return TestPage();
      }));
  }
}
