import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

import 'package:mall/src/parse/parse.dart';
import 'package:mall/src/pages/login/login.dart';
import 'package:mall/src/pages/app/app.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';

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
                      normalWidget: const Text('height=48',
                          style: TextStyle(color: Colors.white)),
                      progressWidget: const CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white)),
                      color: Colors.blueAccent,
                      width: 196,
                      height: 48,
                      onPressed: () async {
                        int score = await Future.delayed(
                            const Duration(milliseconds: 3000), () => 42);
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
