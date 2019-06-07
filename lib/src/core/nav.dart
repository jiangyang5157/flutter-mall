import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import 'package:mall/src/pages/pages.dart';

class Nav {
  Router _router;

  Router get router => _router;

  Nav() {
    _router = Router()
      ..define('SplashPage', handler: Handler(
          handlerFunc: (BuildContext context, Map<String, dynamic> params) {
        return SplashPage();
      }))
      ..define('LoginPage', handler: Handler(
          handlerFunc: (BuildContext context, Map<String, dynamic> params) {
        return LoginPage();
      }))
      ..define('HomePage', handler: Handler(
          handlerFunc: (BuildContext context, Map<String, dynamic> params) {
        return HomePage();
      }));
  }
}
