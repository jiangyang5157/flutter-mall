import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

import 'package:mall/src/parse/parse.dart';
import 'package:mall/src/pages/login/login.dart';
import 'package:mall/src/pages/app/app.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AppBloc _appBloc;
  LoginBloc _loginBloc;

  @override
  void initState() {
    _appBloc = BlocProvider.of<AppBloc>(context);
    _loginBloc = LoginBloc();
    super.initState();
  }

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
                      User user = User();
                      user.set<bool>('anonymous', true);
                      ParseResponse response = await user.loginAnonymous();
                      print('loginAnonymous response=$response');
                    },
                    child: Text('login with anonymous user'),
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
                  RaisedButton(
                    onPressed: () async {
                      User currentUser = await UserRepository().currentUser();
                      print('currentUser=$currentUser');
                    },
                    child: Text('print current user info'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _loginBloc.dispose();
    super.dispose();
  }
}
