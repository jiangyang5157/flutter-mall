import 'package:fluro/fluro.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mall/core/util/localization/string_localization.dart';
import 'package:mall/core/util/nav.dart';
import 'package:mall/core/util/widgets/ext.dart';
import 'package:mall/features/signup/presentation/sign_up_view_model.dart';
import 'package:mall/features/signup/presentation/widgets/sign_up_form.dart';
import 'package:mall/injection.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  SignUpViewModel signUpViewModel = locator<SignUpViewModel>();

  @override
  void dispose() {
    signUpViewModel.dispose();
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

    return Provider<SignUpViewModel>.value(
      value: signUpViewModel,
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
