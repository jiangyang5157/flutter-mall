import 'package:fluro/fluro.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';
import 'package:mall/src/core/core.dart';
import 'package:mall/src/models/models.dart';
import 'package:mall/src/pages/pages.dart';
import 'package:mall/src/utils/utils.dart';
import 'package:mall/src/widgets/widgets.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:provider/provider.dart';

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
        child: ChangeNotifierProvider<AuthModel>.value(
          value: authModel,
          child: Consumer<AuthModel>(
            builder: (context, authModel, _) {
              return LayoutBuilder(
                builder: (context, constraint) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints:
                          BoxConstraints(minHeight: constraint.maxHeight),
                      child: IntrinsicHeight(
                        child: Column(
                          children: <Widget>[
                            FlutterLogo(size: flutterLogoSize), // TODO
                            Padding(
                              padding: const EdgeInsets.all(sizeLarge),
                              child: _buildForm(context, authModel.state),
                            ),
                            Spacer(),
                            Container(
                              height: authBottomContainer,
                              alignment: Alignment.topCenter,
                              child:
                                  _buildFormSelector(context, authModel.state),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
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
        throw ("$authState is not recognized as an AuthState");
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
                  animate: false,
                  onPressed: () async {
                    UserModel userModel = UserModel.create();
                    ParseResponse response = await userModel.signInAnonymous();
                    if (response.success) {
                      userModel.type = UserType.Anonymous;
                      await userModel.save();
                      await userModel.pin();
                      await Provider.of<UserModel>(context).init();
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
      default:
        throw ("$authState is not recognized as an AuthState");
    }
  }
}
