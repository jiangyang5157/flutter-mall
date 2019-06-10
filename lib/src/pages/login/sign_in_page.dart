import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';
import 'package:provider/provider.dart';
import 'package:fluro/fluro.dart';

import 'package:mall/src/models/models.dart';
import 'package:mall/src/core/core.dart';
import 'package:mall/src/widgets/widgets.dart';

class SignInPage extends StatefulWidget {
  SignInPage({Key key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
    print('#### _SignInPageState - dispose');
  }

  @override
  void initState() {
    super.initState();
    print('#### _SignInPageState - initState');

    _usernameController.addListener(() {
      Provider.of<SignInModel>(context).username = _usernameController.text;
    });
    _passwordController.addListener(() {
      Provider.of<SignInModel>(context).password = _passwordController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('#### _SignInPageState - build');

    SignInModel signInModel = Provider.of<SignInModel>(context);
    _usernameController.text = signInModel.username;
    _passwordController.text = signInModel.password;

    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            decoration: InputDecoration(
                labelText: string(context, 'label_username_or_email_address')),
            obscureText: false,
            controller: _usernameController,
            validator: (text) => text.trim().length > 0
                ? null
                : string(context, 'error_empty_username'),
          ),
          TextFormField(
            decoration:
                InputDecoration(labelText: string(context, 'label_password')),
            obscureText: true,
            enableInteractiveSelection: false,
            controller: _passwordController,
            validator: (text) => text.trim().length > 0
                ? null
                : string(context, 'error_empty_password'),
          ),
          ProgressButton(
            defaultWidget: Text(string(context, 'label_sign_in')),
            progressWidget: ThreeSizeDot(),
            animate: false,
            width: 196,
            height: 40,
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                ParseResponse response = await UserModel.createUser(
                        username: _usernameController.text,
                        password: _passwordController.text)
                    .signIn();
                return () {
                  if (mounted) {
                    if (response.success) {
                      locator<Nav>().router.navigateTo(context, 'HomePage',
                          clearStack: true, transition: TransitionType.fadeIn);
                    } else {
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text(response.error.message),
                        duration: Duration(seconds: 3),
                      ));
                    }
                  }
                };
              }
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
