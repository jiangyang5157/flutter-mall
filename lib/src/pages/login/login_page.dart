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
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Login Screen'),
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
