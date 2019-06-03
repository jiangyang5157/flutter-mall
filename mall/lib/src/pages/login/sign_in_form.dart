import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mall/src/pages/login/login.dart';

class SignInForm extends StatefulWidget {
  SignInForm({Key key}) : super(key: key);

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  LoginBloc _loginBloc;

  @override
  void initState() {
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    super.initState();
  }

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginEvent, LoginState>(
      bloc: _loginBloc,
      builder: (_, LoginState state) {
        if (state is InitialLoginState) {
          if (state.user == null) {
            _usernameController.text = null;
            _passwordController.text = null;
          } else {
            _usernameController.text = state.user.username;
            _passwordController.text = state.user.password;
          }
        }

        return Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'username / email'),
                obscureText: false,
                controller: _usernameController,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'password'),
                obscureText: true,
                enableInteractiveSelection: false,
                controller: _passwordController,
              ),
              RaisedButton(
                onPressed: () {
                  _loginBloc.dispatch(SignInEvent(
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
