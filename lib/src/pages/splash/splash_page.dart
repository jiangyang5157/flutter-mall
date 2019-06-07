import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:mall/src/pages/pages.dart';
import 'package:mall/src/models/models.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    AppModel appModel = AppModel();
    AuthModel authModel = AuthModel();
    UserModel userModel = UserModel();

    AppModel().addListener(() {
      switch (appModel.state) {
        case AppState.Uninitialized:
          break;
        case AppState.Initialized:
          break;
      }
    })

    ;
    authModel.addListener(() {});
    userModel.addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    print('#### _SplashPageState build');

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
              onPressed: () {},
              child: Text('SplashPage'),
            ),
          ],
        ),
      ),
    );
  }
}
