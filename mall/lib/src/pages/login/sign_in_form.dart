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
import 'package:mall/src/widgets/widgets.dart';

class SignInForm extends StatefulWidget {
  final AppBloc appBloc;
  final LoginBloc loginBloc;

  SignInForm({Key key, @required this.appBloc, @required this.loginBloc})
      : super(key: key);

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  @override
  void initState() {
    super.initState();
  }

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginEvent, LoginState>(
      bloc: widget.loginBloc,
      builder: (_, LoginState state) {
        if (state is LoginCurrentUserStartState) {
          _usernameController.text = state.user.username;
          _passwordController.text = state.user.password;
        }

        if (state is LoginSuccessState) {
          widget.appBloc.dispatch(AppSignedInEvent());
        }

        return Form(
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'username / email'),
                obscureText: false,
                controller: _usernameController,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'password'),
                obscureText: true,
                controller: _passwordController,
              ),
              RaisedButton(
                onPressed: () {
                  widget.loginBloc.dispatch(SignInEvent(
                      _usernameController.text, _passwordController.text));
                },
                child: Text('sign in'),
              ),
            ],
          ),
        );
      },
    );
  }
}
