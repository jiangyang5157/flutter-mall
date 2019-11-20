import 'package:fluro/fluro.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';
import 'package:mall/constant.dart';
import 'package:mall/core/util/localization/string_localization.dart';
import 'package:mall/core/util/nav.dart';
import 'package:mall/core/util/widgets/ext.dart';
import 'package:mall/core/util/widgets/three_size_dot.dart';
import 'package:mall/features/signin/presentation/sign_in_view_model.dart';
import 'package:mall/features/signin/presentation/widgets/sign_in_form.dart';
import 'package:mall/injection.dart';
import 'package:mall/models/auth/auth_model.dart';
import 'package:mall/models/auth/sign_up_model.dart';
import 'package:mall/models/user/user_model.dart';
import 'package:mall/pages/auth/sign_up_form.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatefulWidget {
  AuthPage({Key key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  AuthModel authModel = AuthModel();
  SignInViewModel signInViewModel = locator<SignInViewModel>();
  SignUpModel signUpModel = SignUpModel();

  @override
  void dispose() {
    signInViewModel.dispose();
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
                            FlutterLogo(size: flutterLogoSize),
                            Padding(
                              padding: const EdgeInsets.all(sizeLarge),
                              child: _buildForm(context, authModel.state),
                            ),
                            Spacer(),
                            Container(
                              height: authBottomContainerHeight,
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
        return Provider<SignInViewModel>.value(
          value: signInViewModel,
          child: Card(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, sizeLarge, 0, 0),
                  child: Text(
                    string(context, 'title_sign_in_form'),
                    style: Theme.of(context).textTheme.title,
                  ),
                ),
                SignInForm(
                  onResponse: (response) {
                    if (response.success) {
                      locator<Nav>().router.navigateTo(context, 'HomePage',
                          clearStack: true, transition: TransitionType.fadeIn);
                    } else {
                      showSimpleSnackBar(
                          Scaffold.of(context), response.error.message);
                    }
                  },
                ),
              ],
            ),
          ),
        );
      case AuthState.SignUp:
        return Provider<SignUpModel>.value(
          value: signUpModel,
          child: Card(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, sizeLarge, 0, 0),
                  child: Text(
                    string(context, 'title_sign_up_form'),
                    style: Theme.of(context).textTheme.title,
                  ),
                ),
                SignUpForm(
                  onResponse: (response) {
                    if (response.success) {
                      locator<Nav>().router.navigateTo(context, 'HomePage',
                          clearStack: true, transition: TransitionType.fadeIn);
                    } else {
                      showSimpleSnackBar(
                          Scaffold.of(context), response.error.message);
                    }
                  },
                ),
              ],
            ),
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
                    UserModel newUserModel = UserModel.create();
                    ParseResponse response =
                        await newUserModel.signInAnonymous();
                    if (response.success) {
                      newUserModel.type = UserType.Anonymous;
                      await newUserModel.save();
                      await Provider.of<UserModel>(context).sync();
                    }
                    return () {
                      if (response.success) {
                        locator<Nav>().router.navigateTo(context, 'HomePage',
                            clearStack: true,
                            transition: TransitionType.fadeIn);
                      } else {
                        showSimpleSnackBar(
                            Scaffold.of(context), response.error.message);
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
