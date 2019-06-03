import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

import 'package:mall/src/parse/parse.dart';
import 'package:mall/src/pages/login/login.dart';
import 'package:mall/src/pages/app/app.dart';
import 'package:mall/src/widgets/widgets.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AppBloc _appBloc;
  LoginBloc _loginBloc;

  @override
  void dispose() {
    _loginBloc.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _appBloc = BlocProvider.of<AppBloc>(context);
    _loginBloc = LoginBloc();
    super.initState();
  }

  int test = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      bloc: _loginBloc,
      child: BlocBuilder(
        bloc: _loginBloc,
        builder: (_, LoginState state) {
          if (state is SignInSuccessState || state is SignUpSuccessState) {
            _appBloc.dispatch(AppSignedInEvent());
          }

          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SignUpForm(),
                  SignInForm(),
                  RaisedButton(
                    onPressed: () async {
                      User user = await UserRepository().currentUser();
                      print(user);
                    },
                    child: Text('print current user info'),
                  ),
                  RaisedButton(
                    onPressed: () async {
                      User currentUser = await UserRepository().currentUser();
                      ParseResponse response =
                          await UserRepository().forget(currentUser);
                      print('destroy response=$response');
                    },
                    child: Text('forget user'),
                  ),
                  Padding(
                    padding: EdgeInsets.all(4.0),
                    child: ProgressButton(
                      'login with anonymous user',
                      width: 196,
                      onProcess: () async {
                        User user = User();
                        user.set<bool>('anonymous', true);
                        ParseResponse response = await user.loginAnonymous();
                        return () {
                          print('loginAnonymous response=$response');
                          if (response.success) {
                            _appBloc.dispatch(AppSignedInEvent());
                          }
                        };
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(4.0),
                    child: ProgressButton(
                      'await 1 second',
                      width: 196,
                      onProcess: () async {
                        await Future.delayed(
                            const Duration(milliseconds: 1000));
                        return () {
                          print('1 second await done');
                        };
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(4.0),
                    child: ProgressButton(
                      'no await',
                      width: 196,
                      onProcess: () {
                        print('no await');
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
