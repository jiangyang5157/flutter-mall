import 'package:fluro/fluro.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';
import 'package:mall/core/constant.dart';
import 'package:mall/core/util/localization/string_localization.dart';
import 'package:mall/core/util/nav.dart';
import 'package:mall/core/util/widgets/ext.dart';
import 'package:mall/core/util/widgets/three_size_dot.dart';
import 'package:mall/features/auth/domain/entities/auth_entity.dart';
import 'package:mall/features/auth/presentation/auth_view_model.dart';
import 'package:mall/features/signin/presentation/sign_in_view_model.dart';
import 'package:mall/features/signin/presentation/widgets/sign_in_form.dart';
import 'package:mall/features/signup/presentation/sign_up_view_model.dart';
import 'package:mall/features/signup/presentation/widgets/sign_up_form.dart';
import 'package:mall/core/injection.dart';
import 'package:mall/models/user_model.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatefulWidget {
  AuthPage({Key key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  AuthViewModel authViewModel = locator<AuthViewModel>();
  SignInViewModel signInViewModel = locator<SignInViewModel>();
  SignUpViewModel signUpViewModel = locator<SignUpViewModel>();

  @override
  void dispose() {
    authViewModel.dispose();
    signInViewModel.dispose();
    signUpViewModel.dispose();
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
        child: ChangeNotifierProvider<AuthViewModel>.value(
          value: authViewModel,
          child: Consumer<AuthViewModel>(
            builder: (context, authViewModel, _) {
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
                              child: _buildForm(context, authViewModel.getCurrentData().state),
                            ),
                            Spacer(),
                            Container(
                              height: authBottomContainerHeight,
                              alignment: Alignment.topCenter,
                              child:
                                  _buildFormSelector(context, authViewModel.getCurrentData().state),
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

  Widget _buildForm(BuildContext context, AuthState state) {
    switch (state) {
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
        return Provider<SignUpViewModel>.value(
          value: signUpViewModel,
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
        throw ("$state is not recognized as an AuthState");
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
                    authViewModel.setCurrentData(AuthState.SignUp, notify: true);
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
                authViewModel.setCurrentData(AuthState.SignIn, notify: true);
              },
            ),
          ],
        );
      default:
        throw ("$authState is not recognized as an AuthState");
    }
  }
}
