import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stetho/flutter_stetho.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

import 'package:mall/src/pages/login/login.dart';
import 'package:mall/src/pages/theme_app/theme_app.dart';
import 'package:mall/src/pages/app/app.dart';
import 'package:mall/src/pages/home/home.dart';

class SignUpForm extends StatefulWidget {
  LoginBloc loginBloc;

  SignUpForm({Key key, @required this.loginBloc}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  @override
  void initState() {
    super.initState();
  }

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailAddressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginEvent, LoginState>(
      bloc: widget.loginBloc,
      builder: (_, LoginState state) {
        return Form(
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'username'),
                obscureText: false,
                controller: _usernameController,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'password'),
                obscureText: true,
                controller: _passwordController,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'email address'),
                obscureText: true,
                controller: _emailAddressController,
              ),
              RaisedButton(
                onPressed: _onBtnSignUpPressed,
                child: Text('sign up'),
              ),
            ],
          ),
        );
//        if (state is LoginFailureState) {
//          _onWidgetDidBuild(() {
//            Scaffold.of(context).showSnackBar(
//              SnackBar(
//                content: Text('${state.error}'),
//                backgroundColor: Colors.red,
//              ),
//            );
//          });
//        }
//        if (state is LoginStartState) {
//          _onWidgetDidBuild(() {
//            Scaffold.of(context).showSnackBar(
//              SnackBar(
//                content: Text('sign up start'),
//                backgroundColor: Colors.red,
//              ),
//            );
//          });
//        }
//        if (state is LoginSuccessState) {
//          _onWidgetDidBuild(() {
//            Scaffold.of(context).showSnackBar(
//              SnackBar(
//                content: Text('sign up success'),
//                backgroundColor: Colors.red,
//              ),
//            );
//          });
//        }
      },
    );
  }

  void _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

  _onBtnSignUpPressed() {
    widget.loginBloc.dispatch(SignUpEvent(
      _usernameController.text,
      _passwordController.text,
      _emailAddressController.text,
    ));
  }
}
