import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';
import 'package:provider/provider.dart';

import 'package:mall/src/models/models.dart';
import 'package:mall/src/core/core.dart';
import 'package:mall/src/widgets/widgets.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailAddressController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _emailAddressController.dispose();
    super.dispose();
    print('#### _SignUpPageState - dispose');
  }

  @override
  void initState() {
    super.initState();
    print('#### _SignUpPageState - initState');

    _usernameController.addListener(() {
      Provider.of<SignUpModel>(context).username = _usernameController.text;
    });
    _passwordController.addListener(() {
      Provider.of<SignUpModel>(context).password = _passwordController.text;
    });
    _emailAddressController.addListener(() {
      Provider.of<SignUpModel>(context).emailAddress =
          _emailAddressController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('#### _SignUpPageState - build');

    SignUpModel signUpModel = Provider.of<SignUpModel>(context);
    _usernameController.text = signUpModel.username;
    _passwordController.text = signUpModel.password;
    _emailAddressController.text = signUpModel.emailAddress;

    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            decoration:
                InputDecoration(labelText: string(context, 'label_username')),
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
          TextFormField(
            decoration: InputDecoration(
                labelText: string(context, 'label_email_address')),
            obscureText: false,
            controller: _emailAddressController,
            validator: (text) => text.trim().length > 0
                ? null
                : string(context, 'error_empty_email_address'),
          ),
          ProgressButton(
            defaultWidget: Text(string(context, 'label_sign_up')),
            progressWidget: ThreeSizeDot(),
            animate: false,
            width: 196,
            height: 40,
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                ParseResponse response = await UserModel.createUser(
                        username: _usernameController.text,
                        password: _passwordController.text,
                        emailAddress: _emailAddressController.text)
                    .signUp();
                return () {
                  if (response.success) {
                    if (mounted) {
                      locator<Nav>()
                          .router
                          .navigateTo(context, 'HomePage', clearStack: true);
                    }
                  }
                };
              }
            },
          ),
          RaisedButton(
            onPressed: () {
              Provider.of<LoginModel>(context).state = LoginState.SignIn;
            },
            child: Text(
              string(context, 'prompt_go_to_sign_in'),
            ),
          ),
        ],
      ),
    );
  }
}
