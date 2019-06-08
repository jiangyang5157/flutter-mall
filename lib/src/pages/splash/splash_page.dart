import 'package:flutter/material.dart';

import 'package:mall/src/core/core.dart';
import 'package:mall/src/models/models.dart';

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
    super.dispose();
    print('#### _SplashPageState - dispose');
    appModel.dispose();
    userModel.dispose();
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
              locator<Nav>()
                  .router
                  .navigateTo(context, 'LoginPage', clearStack: true);
            } else {
              locator<Nav>()
                  .router
                  .navigateTo(context, 'HomePage', clearStack: true);
            }
          });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print('#### _SplashPageState - build');

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(),
          ],
        ),
      ),
    );
  }
}
