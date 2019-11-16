import 'package:fluro/fluro.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mall/core/util/localization/string_localization.dart';
import 'package:mall/core/util/nav.dart';
import 'package:mall/core/util/widgets/ext.dart';
import 'package:mall/injection.dart';
import 'package:mall/models/auth/sign_up_model.dart';
import 'package:mall/pages/auth/sign_up_form.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  SignUpModel signUpModel = SignUpModel();

  @override
  void dispose() {
    signUpModel.dispose();
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

    return Provider<SignUpModel>.value(
      value: signUpModel,
      child: Scaffold(
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
      ),
    );
  }
}
