import 'package:fluro/fluro.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mall/src/core/locator.dart';
import 'package:mall/src/models/auth/sign_up_model.dart';
import 'package:mall/src/pages/auth/sign_up_form.dart';
import 'package:mall/src/utils/utils.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  SignUpModel signUpModel = SignUpModel();

  @override
  void dispose() {
    super.dispose();
    signUpModel.dispose();
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

    return Scaffold(
      appBar: AppBar(
        title: Text(string(context, 'title_sign_up_page')),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: SignUpForm(
                onResponse: (response) {
                  if (response.success) {
                    locator<Nav>().router.navigateTo(context, 'HomePage',
                        clearStack: true, transition: TransitionType.fadeIn);
                  } else {
                    showSimpleSnackBar(
                        Scaffold.of(context), response.error.message);
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
