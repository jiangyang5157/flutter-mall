import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import 'package:mall/src/pages/pages.dart';

class App {
  static final App _instance = App._internal();

  factory App() {
    return _instance;
  }

  ThemeData _themeData;

  ThemeData get themeData => _themeData;

  Router _router;

  Router get router => _router;

  App._internal() {
    _themeData = ThemeData(brightness: Brightness.light);

    _router = Router()
      ..define('/', handler: Handler(
          handlerFunc: (BuildContext context, Map<String, dynamic> params) {
        return SplashPage();
      }))
      ..define('/landing', handler: Handler(
          handlerFunc: (BuildContext context, Map<String, dynamic> params) {
        return LandingPage();
      }))
      ..define('/login', handler: Handler(
          handlerFunc: (BuildContext context, Map<String, dynamic> params) {
        return LoginPage();
      }))
      ..define('/home', handler: Handler(
          handlerFunc: (BuildContext context, Map<String, dynamic> params) {
        return HomePage();
      }));
  }
}
