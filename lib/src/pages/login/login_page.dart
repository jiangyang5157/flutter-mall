import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:mall/src/models/models.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    ThemeModel themeModel = Provider.of<ThemeModel>(context);
    AuthModel authModel = Provider.of<AuthModel>(context);
    UserModel userModel = Provider.of<UserModel>(context);
    print('#### _LoginPageState build');

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
              onPressed: () {
//                authModel.authState = AuthState.Authenticated;
                themeModel.themeType = ThemeType.Dark;
              },
              child: Text('auth'),
            ),
          ],
        ),
      ),
    );
  }
}
