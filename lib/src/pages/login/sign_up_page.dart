import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';
import 'package:provider/provider.dart';

import 'package:mall/src/models/models.dart';
import 'package:mall/src/core/core.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailAddressController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    print('#### _SignUpPageState - dispose');
  }

  @override
  void initState() {
    super.initState();
    print('#### _SignUpPageState - initState');
  }

  @override
  Widget build(BuildContext context) {
    print('#### _SignUpPageState - build');

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
          ProgressButton(
            normalWidget: Text('Sign Up'),
            progressWidget: const CircularProgressIndicator(),
            width: 196,
            height: 40,
            onPressed: () async {
              ParseResponse response = await UserModel.createUser(
                      username: _usernameController.text,
                      password: _passwordController.text,
                      emailAddress: _emailAddressController.text)
                  .signUp();
              return () {
                if (response.success) {
                  locator<Nav>()
                      .router
                      .navigateTo(context, 'HomePage', clearStack: true);
                }
              };
            },
          ),
          RaisedButton(
            onPressed: () {
              Provider.of<LoginModel>(context).state = LoginState.SignIn;
            },
            child: Text('To Sign In'),
          ),
        ],
      ),
    );
  }
}
