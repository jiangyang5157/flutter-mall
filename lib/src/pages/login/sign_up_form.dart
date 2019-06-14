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

class SignUpForm extends StatefulWidget {
  SignUpForm({Key key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  final _usernameController = TextEditingControllerWorkaround();
  final _passwordController = TextEditingControllerWorkaround();
  final _emailAddressController = TextEditingControllerWorkaround();
  final FocusNode _usernameFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _emailAddressFocusNode = FocusNode();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _emailAddressController.dispose();
    super.dispose();
    print('#### _SignUpFormState - dispose');
  }

  @override
  void initState() {
    super.initState();
    print('#### _SignUpFormState - initState');

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
    print('#### _SignUpFormState - build');

    SignUpModel signUpModel = Provider.of<SignUpModel>(context);
    _usernameController.setTextAndPosition(signUpModel.username);
    _passwordController.setTextAndPosition(signUpModel.password);
    _emailAddressController.setTextAndPosition(signUpModel.emailAddress);

    return Container(
      padding: new EdgeInsets.fromLTRB(formPaddingLR, 0, formPaddingLR, 0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              padding: new EdgeInsets.all(formTitlePaddingLTRB),
              child: Text(
                string(context, 'title_sign_up_form'),
                style: Theme.of(context).textTheme.title,
              ),
            ),
            TextFormField(
              decoration:
                  InputDecoration(labelText: string(context, 'label_username')),
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
              textInputAction: TextInputAction.next,
              obscureText: true,
              enableInteractiveSelection: false,
              controller: _passwordController,
              focusNode: _passwordFocusNode,
              onFieldSubmitted: (_) =>
                  FocusScope.of(context).requestFocus(_emailAddressFocusNode),
              validator: (text) =>
                  string(context, PasswordValidator().validate(text)),
              inputFormatters: [PasswordInputFormatter()],
            ),
            TextFormField(
              decoration: InputDecoration(
                  labelText: string(context, 'label_email_address')),
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              controller: _emailAddressController,
              focusNode: _emailAddressFocusNode,
              validator: (text) =>
                  string(context, EmailAddressValidator().validate(text)),
              inputFormatters: [EmailAddressInputFormatter()],
            ),
            ProgressButton(
              defaultWidget: Text(string(context, 'label_sign_up')),
              progressWidget: ThreeSizeDot(),
              animate: false,
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
