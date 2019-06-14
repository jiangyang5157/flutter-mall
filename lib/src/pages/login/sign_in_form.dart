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

class SignInForm extends StatefulWidget {
  SignInForm({Key key}) : super(key: key);

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  final _usernameController = TextEditingControllerWorkaround();
  final _passwordController = TextEditingControllerWorkaround();
  final FocusNode _usernameFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
    print('#### _SignInFormState - dispose');
  }

  @override
  void initState() {
    super.initState();
    print('#### _SignInFormState - initState');

    _usernameController.addListener(() {
      Provider.of<SignInModel>(context).username = _usernameController.text;
    });
    _passwordController.addListener(() {
      Provider.of<SignInModel>(context).password = _passwordController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('#### _SignInFormState - build');

    SignInModel signInModel = Provider.of<SignInModel>(context);
    _usernameController.setTextAndPosition(signInModel.username);
    _passwordController.setTextAndPosition(signInModel.password);

    return Container(
      padding: new EdgeInsets.fromLTRB(formPaddingLR, 0, formPaddingLR, 0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              padding:
                  new EdgeInsets.all(formTitlePaddingLTRB),
              child: Text(
                string(context, 'title_sign_in_form'),
                style: Theme.of(context).textTheme.title,
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                  labelText:
                      string(context, 'label_username_or_email_address')),
              textInputAction: TextInputAction.next,
              controller: _usernameController,
              focusNode: _usernameFocusNode,
              onFieldSubmitted: (_) =>
                  FocusScope.of(context).requestFocus(_passwordFocusNode),
              validator: (text) =>
                  string(context, UsernameValidator().validate(text)),
              inputFormatters: [UsernameInputFormatter()],
            ),
            TextFormField(
              decoration:
                  InputDecoration(labelText: string(context, 'label_password')),
              textInputAction: TextInputAction.done,
              obscureText: true,
              enableInteractiveSelection: false,
              controller: _passwordController,
              focusNode: _passwordFocusNode,
              validator: (text) =>
                  string(context, PasswordValidator().validate(text)),
              inputFormatters: [PasswordInputFormatter()],
            ),
            ProgressButton(
              defaultWidget: Text(string(context, 'label_sign_in')),
              progressWidget: ThreeSizeDot(),
              animate: false,
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  ParseResponse response = await UserModel.createUser(
                          username: _usernameController.text,
                          password: _passwordController.text)
                      .signIn();
                  return () {
                    _passwordController.clear();
                    if (mounted) {
                      if (response.success) {
                        locator<Nav>().router.navigateTo(context, 'HomePage',
                            clearStack: true,
                            transition: TransitionType.fadeIn);
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
          ],
        ),
      ),
    );
  }
}

//Widget buildTopChild(LoginState loginState) {
//  switch (loginState) {
//    case LoginState.SignIn:
//      return Column(
//        mainAxisAlignment: MainAxisAlignment.end,
//        children: [
//          Text(string(context, 'prompt_sign_in_form')),
//        ],
//      );

//    case LoginState.SignUp:
//      return Column(
//        mainAxisAlignment: MainAxisAlignment.end,
//        children: [
//          Text(string(context, 'prompt_sign_up_form')),
//        ],
//      );
//  }
//}
