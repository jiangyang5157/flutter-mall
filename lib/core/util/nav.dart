import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mall/features/auth/presentation/pages/auth_page.dart';
import 'package:mall/features/settings/presentation/pages/sign_up_page.dart';
import 'package:mall/features/startup/presentation/pages/splash_page.dart';
import 'package:mall/features/home/presentation/pages/home_page.dart';
import 'package:mall/features/settings/presentation/pages/change_display_picture_page.dart';
import 'package:mall/features/settings/presentation/pages/change_email_page.dart';
import 'package:mall/features/settings/presentation/pages/change_password_page.dart';
import 'package:mall/features/settings/presentation/pages/change_username_page.dart';
import 'package:mall/features/settings/presentation/pages/settings_page.dart';

class Nav {
  Router _router;

  Router get router => _router;

  Nav() {
    _router = Router()
      ..define('SplashPage', handler: Handler(
          handlerFunc: (BuildContext context, Map<String, dynamic> params) {
        return SplashPage();
      }))
      ..define('AuthPage', handler: Handler(
          handlerFunc: (BuildContext context, Map<String, dynamic> params) {
        return AuthPage();
      }))
      ..define('HomePage', handler: Handler(
          handlerFunc: (BuildContext context, Map<String, dynamic> params) {
        return HomePage();
      }))
      ..define('SettingsPage', handler: Handler(
          handlerFunc: (BuildContext context, Map<String, dynamic> params) {
        return SettingsPage();
      }))
      ..define('SignUpPage', handler: Handler(
          handlerFunc: (BuildContext context, Map<String, dynamic> params) {
        return SignUpPage();
      }))
      ..define('ChangeDisplayPicturePage', handler: Handler(
          handlerFunc: (BuildContext context, Map<String, dynamic> params) {
        return ChangeDisplayPicturePage();
      }))
      ..define('ChangeUsernamePage', handler: Handler(
          handlerFunc: (BuildContext context, Map<String, dynamic> params) {
        return ChangeUsernamePage();
      }))
      ..define('ChangePasswordPage', handler: Handler(
          handlerFunc: (BuildContext context, Map<String, dynamic> params) {
        return ChangePasswordPage();
      }))
      ..define('ChangeEmailPage', handler: Handler(
          handlerFunc: (BuildContext context, Map<String, dynamic> params) {
        return ChangeEmailPage();
      }));
  }

  void exit() {
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }
}
