import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:mall/src/models/models.dart';
import 'package:mall/src/pages/pages.dart';
import 'package:mall/src/utils/utils.dart';

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
            resizeToAvoidBottomPadding: false,
            body: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                new Expanded(
                  child: Container(),
                  flex: 1,
                ),
                new Expanded(
                  child: buildCenterChild(loginModel.state),
                  flex: 2,
                ),
                new Expanded(
                  child: buildBottomChild(loginModel.state),
                  flex: 1,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildCenterChild(LoginState loginState) {
    switch (loginState) {
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
    }
  }

  Widget buildBottomChild(LoginState loginState) {
    switch (loginState) {
      case LoginState.SignIn:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(string(context, 'prompt_go_to_sign_up')),
            FlatButton(
              child: Text(
                string(context, 'prompt_sign_up_action'),
                style: TextStyle(
                  color: Theme.of(context).textTheme.title.color,
                  decoration: TextDecoration.underline,
                ),
              ),
              onPressed: () {
                loginModel.state = LoginState.SignUp;
              },
            ),
          ],
        );
      case LoginState.SignUp:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(string(context, 'prompt_go_to_sign_in')),
            FlatButton(
              child: Text(
                string(context, 'prompt_sign_in_action'),
                style: TextStyle(
                  color: Theme.of(context).textTheme.title.color,
                  decoration: TextDecoration.underline,
                ),
              ),
              onPressed: () {
                loginModel.state = LoginState.SignIn;
              },
            ),
          ],
        );
    }
  }
}
