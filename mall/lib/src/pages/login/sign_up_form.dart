import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mall/src/pages/login/login.dart';

class SignUpForm extends StatefulWidget {
  SignUpForm({Key key}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  LoginBloc _loginBloc;

  @override
  void initState() {
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    super.initState();
  }

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailAddressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginEvent, LoginState>(
      bloc: _loginBloc,
      builder: (_, LoginState state) {
        if (state is InitialLoginState) {
          _usernameController.text = null;
          _passwordController.text = null;
        }

        return Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'username'),
                obscureText: false,
                controller: _usernameController,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'password'),
                obscureText: true,
                enableInteractiveSelection: false,
                controller: _passwordController,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'email address'),
                obscureText: false,
                controller: _emailAddressController,
              ),
              RaisedButton(
                onPressed: () {
                  _loginBloc.dispatch(SignUpEvent(_usernameController.text,
                      _passwordController.text, _emailAddressController.text));
                },
                child: Text('sign up'),
              ),
            ],
          ),
        );
      },
    );
  }
}
