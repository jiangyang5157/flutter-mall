import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';
import 'package:provider/provider.dart';

import 'package:mall/src/models/models.dart';
import 'package:mall/src/core/core.dart';
import 'package:mall/src/widgets/widgets.dart';

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
            decoration: InputDecoration(
                labelText: string(context, 'label_username_or_email_address')),
            obscureText: false,
            controller: _usernameController,
          ),
          TextFormField(
            decoration:
                InputDecoration(labelText: string(context, 'label_password')),
            obscureText: true,
            enableInteractiveSelection: false,
            controller: _passwordController,
          ),
          ProgressButton(
            defaultWidget: Text(string(context, 'label_sign_in')),
            progressWidget: ThreeSizeDot(),
            animate: false,
            width: 196,
            height: 40,
            onPressed: () async {
              ParseResponse response = await UserModel.createUser(
                      username: _usernameController.text,
                      password: _passwordController.text)
                  .signIn();
              return () {
                if (response.success) {
                  if (mounted) {
                    locator<Nav>()
                        .router
                        .navigateTo(context, 'HomePage', clearStack: true);
                  }
                }
              };
            },
          ),
          RaisedButton(
            onPressed: () {
              Provider.of<LoginModel>(context).state = LoginState.SignUp;
            },
            child: Text(string(context, 'prompt_go_to_sign_up')),
          ),
        ],
      ),
    );
  }
}
