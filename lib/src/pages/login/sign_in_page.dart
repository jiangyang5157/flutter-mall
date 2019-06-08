import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';

import 'package:mall/src/models/models.dart';
import 'package:mall/src/core/core.dart';

class SignInPage extends StatefulWidget {
  SignInPage({Key key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    print('#### _SignInPageState - dispose');
  }

  @override
  void initState() {
    super.initState();
    print('#### _SignInPageState - initState');
  }

  @override
  Widget build(BuildContext context) {
    print('#### _SignInPageState - build');

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
          ProgressButton(
            normalWidget: Text('Sign In'),
            progressWidget: const CircularProgressIndicator(),
//            width: 196,
//            height: 40,
            onPressed: () async {
              ParseResponse response =
                  await UserModel(ParseUserModel(ParseUser.createUser(
                _usernameController.text,
                _passwordController.text,
              ))).signIn();
              return () {
                if (response.success) {
                  locator<Nav>()
                      .router
                      .navigateTo(context, 'HomePage', clearStack: true);
                }
              };
            },
          ),
        ],
      ),
    );
  }
}
