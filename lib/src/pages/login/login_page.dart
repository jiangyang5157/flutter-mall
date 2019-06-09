import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:mall/src/models/models.dart';
import 'package:mall/src/pages/pages.dart';

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

    return ChangeNotifierProvider<LoginModel>(
      builder: (_) => LoginModel(),
      child: Consumer<LoginModel>(
        builder: (context, loginModel, _) {
          return Scaffold(body: buildChildren(loginModel.state));
        },
      ),
    );
  }

  Widget buildChildren(LoginState loginState) {
    switch (loginState) {
      case LoginState.SignIn:
        return SignInPage();
      case LoginState.SignUp:
        return SignUpPage();
    }
  }
}
