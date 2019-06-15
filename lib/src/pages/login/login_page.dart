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
  LoginModel loginModel = LoginModel();
  SignInModel signInModel = SignInModel();
  SignUpModel signUpModel = SignUpModel();

  @override
  void dispose() {
    signInModel.dispose();
    signUpModel.dispose();
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
      builder: (_) => loginModel,
      child: Consumer<LoginModel>(
        builder: (context, loginModel, _) {
          return Scaffold(
            body: SafeArea(
              // Use expanded ListView instead of shrinking SingleChildScrollView
              child: ListView(
                children: <Widget>[
                  SizedBox(
                    height: 96,
                    child: FlutterLogo(),
                  ),
                  ChangeNotifierProvider<LoginModel>(
                    builder: (_) => loginModel,
                    child: Consumer<LoginModel>(
                      builder: (context, loginModel, _) {
                        switch (loginModel.state) {
                          case LoginState.SignIn:
                            return Provider<SignInModel>.value(
                              value: signInModel,
                              child: SignInForm(),
                            );
                          case LoginState.SignUp:
                            return Provider<SignUpModel>.value(
                              value: signUpModel,
                              child: SignUpForm(),
                            );
                          default:
                            return SizedBox.shrink();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
