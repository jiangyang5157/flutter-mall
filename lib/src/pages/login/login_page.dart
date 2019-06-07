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
  void dispose() {
    super.dispose();
    print('#### _LoginPageState - dispose');
  }

  @override
  void initState() {
    super.initState();
    print('#### _LoginPageState - initState');
  }

  @override
  Widget build(BuildContext context) {
    print('#### _LoginPageState - build');
    ThemeModel themeModel = Provider.of<ThemeModel>(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
              onPressed: () {
                themeModel.typeIn.add(ThemeType.Dark);
              },
              child: Text('auth'),
            ),
          ],
        ),
      ),
    );
  }
}
