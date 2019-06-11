import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';
import 'package:provider/provider.dart';
import 'package:fluro/fluro.dart';

import 'package:mall/src/models/models.dart';
import 'package:mall/src/core/core.dart';
import 'package:mall/src/widgets/widgets.dart';
import 'package:mall/src/utils/utils.dart';

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
            validator: (text) =>
                string(context, UsernameValidator().validate(text)),
          ),
          TextFormField(
            decoration:
                InputDecoration(labelText: string(context, 'label_password')),
            obscureText: true,
            enableInteractiveSelection: false,
            controller: _passwordController,
            validator: (text) =>
                string(context, PasswordValidator().validate(text)),
          ),
          TextFormField(
            decoration: InputDecoration(
                labelText: string(context, 'label_email_address')),
            obscureText: false,
            controller: _emailAddressController,
            validator: (text) =>
                string(context, EmailAddressValidator().validate(text)),
          ),
          ProgressButton(
            defaultWidget: Text(string(context, 'label_sign_up')),
            progressWidget: ThreeSizeDot(),
            animate: false,
            width: 196,
            height: 40,
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                UserModel userModel = UserModel.createUser(
                    username: _usernameController.text,
                    password: _passwordController.text,
                    emailAddress: _emailAddressController.text);
                ParseResponse response = await userModel.signUp();
                if (response.success) {
                  // TODO: parse_server_sdk is not yet support including more properties other then username/password/emailAddress during signUp.
                  userModel.user.type = UserType.Master;
                  await userModel.save();
                }
                return () {
                  if (mounted) {
                    if (response.success) {
                      locator<Nav>().router.navigateTo(context, 'HomePage',
                          clearStack: true, transition: TransitionType.fadeIn);
                    } else {
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text(response.error.message),
                        duration: Duration(
                            milliseconds: snackBarDurationInMilliseconds),
                      ));
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
