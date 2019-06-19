import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluro/fluro.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';

import 'package:mall/src/models/models.dart';
import 'package:mall/src/widgets/widgets.dart';
import 'package:mall/src/pages/pages.dart';
import 'package:mall/src/utils/utils.dart';
import 'package:mall/src/core/core.dart';

class AuthPage extends StatefulWidget {
  AuthPage({Key key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  AuthModel authModel = AuthModel();
  SignInModel signInModel = SignInModel();
  SignUpModel signUpModel = SignUpModel();

  @override
  void dispose() {
    signInModel.dispose();
    signUpModel.dispose();
    super.dispose();
    print('#### _AuthPageState - dispose');
  }

  @override
  void initState() {
    super.initState();
    print('#### _AuthPageState - initState');
  }

  @override
  Widget build(BuildContext context) {
    print('#### _AuthPageState - build');

    return Scaffold(
      body: SafeArea(
        // Use expanded ListView instead of shrinking SingleChildScrollView
        child: ChangeNotifierProvider<AuthModel>(
          builder: (_) => authModel,
          child: Consumer<AuthModel>(
            builder: (context, authModel, _) {
              return ListView(
                children: <Widget>[
                  SizedBox(
                    height: 96, // TODO:
                    child: FlutterLogo(),
                  ),
                  _buildForm(context, authModel.state),
                  _buildFormSelector(context, authModel.state),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildForm(BuildContext context, AuthState authState) {
    switch (authState) {
      case AuthState.SignIn:
        return Provider<SignInModel>.value(
          value: signInModel,
          child: SignInForm(
            onResponse: (response) {
              if (response.success) {
                locator<Nav>().router.navigateTo(context, 'HomePage',
                    clearStack: true, transition: TransitionType.fadeIn);
              } else {
                showSimpleSnackBar(context, response.error.message);
              }
            },
          ),
        );
      case AuthState.SignUp:
        return Provider<SignUpModel>.value(
          value: signUpModel,
          child: SignUpForm(
            onResponse: (response) {
              if (response.success) {
                locator<Nav>().router.navigateTo(context, 'HomePage',
                    clearStack: true, transition: TransitionType.fadeIn);
              } else {
                showSimpleSnackBar(context, response.error.message);
              }
            },
          ),
        );
      default:
        return SizedBox.shrink();
    }
  }

  Widget _buildFormSelector(BuildContext context, AuthState authState) {
    switch (authState) {
      case AuthState.SignIn:
        return Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(string(context, 'prompt_sign_up_action')),
                FlatButton(
                  child: Text(
                    string(context, 'label_sign_up_action'),
                  ),
                  onPressed: () {
                    authModel.state = AuthState.SignUp;
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(string(context, 'prompt_quick_start_action')),
                ProgressButton(
                  defaultWidget: Text(string(context, 'label_anonymous_login')),
                  progressWidget: ThreeSizeDot(
                    color_1: Theme.of(context).buttonTheme.colorScheme.primary,
                    color_2: Theme.of(context).buttonTheme.colorScheme.primary,
                    color_3: Theme.of(context).buttonTheme.colorScheme.primary,
                  ),
                  type: ProgressButtonType.Flat,
                  width: 148,
                  height: btnHeight,
                  animate: false,
                  onPressed: () async {
                    UserModel userModel = UserModel.create();
                    ParseResponse response = await userModel.signInAnonymous();
                    if (response.success) {
                      userModel.type = UserType.Anonymous;
                      await userModel.save();
                    }
                    return () {
                      if (response.success) {
                        locator<Nav>().router.navigateTo(context, 'HomePage',
                            clearStack: true,
                            transition: TransitionType.fadeIn);
                      } else {
                        showSimpleSnackBar(context, response.error.message);
                      }
                    };
                  },
                ),
              ],
            ),
          ],
        );
      case AuthState.SignUp:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(string(context, 'prompt_sign_in_action')),
            FlatButton(
              child: Text(
                string(context, 'label_sign_in_action'),
              ),
              onPressed: () {
                authModel.state = AuthState.SignIn;
              },
            ),
          ],
        );
    }
  }
}
