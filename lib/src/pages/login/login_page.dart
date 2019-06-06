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
    print('#### _LoginPageState build');
    AuthModel authModel = Provider.of<AuthModel>(context);
    UserModel userModel = Provider.of<UserModel>(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
              onPressed: () {
                Provider.of<AuthModel>(context).authState =
                    AuthState.Authenticated;
              },
              child: Text('auth'),
            ),
          ],
        ),
      ),
    );
  }
}
