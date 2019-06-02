import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stetho/flutter_stetho.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

import 'package:mall/src/parse/parse.dart';
import 'package:mall/src/pages/login/login.dart';
import 'package:mall/src/pages/theme_app/theme_app.dart';
import 'package:mall/src/pages/app/app.dart';
import 'package:mall/src/pages/home/home.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  ThemeAppBloc _themeBloc;
  AppBloc _appBloc;
  LoginBloc _loginBloc;

  @override
  void initState() {
    _themeBloc = BlocProvider.of<ThemeAppBloc>(context);
    _appBloc = BlocProvider.of<AppBloc>(context);
    _loginBloc = LoginBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SignUpForm(appBloc: _appBloc, loginBloc: _loginBloc),
            SignInForm(appBloc: _appBloc, loginBloc: _loginBloc),
            RaisedButton(
              onPressed: () {
                _themeBloc.dispatch(ThemeAppLightEvent());
              },
              child: Text('light'),
            ),
            RaisedButton(
              onPressed: () {
                _themeBloc.dispatch(ThemeAppDarkEvent());
              },
              child: Text('dark'),
            ),
            RaisedButton(
              onPressed: () async {
                User user = await UserRepository().currentUser();
                print("#### currentUser=$user");
              },
              child: Text('check current user'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _loginBloc.dispose();
    super.dispose();
  }
}
