import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

import 'package:mall/src/core/core.dart';
import 'package:mall/src/models/models.dart';
import 'package:mall/src/utils/utils.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  AppModel appModel = AppModel();
  UserModel userModel = UserModel();

  @override
  void dispose() {
    appModel.dispose();
    userModel.dispose();
    super.dispose();
    print('#### _SplashPageState - dispose');
  }

  @override
  void initState() {
    super.initState();
    print('#### _SplashPageState - initState');

    appModel.stateOut.listen((AppState state) {
      switch (state) {
        case AppState.Initialized:
          userModel.userOut.listen((ParseUserModel user) {
            if (userModel.user == null) {
              locator<Nav>().router.navigateTo(context, 'LoginPage',
                  clearStack: true, transition: TransitionType.fadeIn);
            } else {
              locator<Nav>().router.navigateTo(context, 'HomePage',
                  clearStack: true, transition: TransitionType.fadeIn);
            }
          });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print('#### _SplashPageState - build');
    return Scaffold();
  }
}
