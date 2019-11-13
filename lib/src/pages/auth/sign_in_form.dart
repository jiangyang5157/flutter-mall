import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';
import 'package:mall/src/core/core.dart';
import 'package:mall/src/models/models.dart';
import 'package:mall/src/utils/utils.dart';
import 'package:mall/src/widgets/widgets.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:provider/provider.dart';

class SignInForm extends StatefulWidget {
  final Function(ParseResponse response) onResponse;

  SignInForm({Key key, @required this.onResponse}) : super(key: key);

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingControllerWorkaround _usernameController = TextEditingControllerWorkaround();
  final TextEditingControllerWorkaround _passwordController = TextEditingControllerWorkaround();
  final FocusNode _usernameFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _usernameFocusNode.dispose();
    _passwordFocusNode.dispose();
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

    return Card(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, sizeLarge, 0, 0),
              child: Text(
                string(context, 'title_sign_in_form'),
                style: Theme.of(context).textTheme.title,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.fromLTRB(sizeLarge, sizeLarge, sizeLarge, 0),
              child: SizedBox(
                height: textFieldHeight,
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: string(context, 'label_username'),
                    hintStyle: TextStyle(fontSize: textFieldFontSize),
                    contentPadding: const EdgeInsets.fromLTRB(
                        0, textFieldContentPaddingT, 0, 0),
                    prefixIcon: Icon(Icons.person),
                  ),
                  style: TextStyle(fontSize: textFieldFontSize),
                  textInputAction: TextInputAction.next,
                  controller: _usernameController,
                  focusNode: _usernameFocusNode,
                  onFieldSubmitted: (_) =>
                      FocusScope.of(context).requestFocus(_passwordFocusNode),
                  validator: (text) =>
                      string(context, UsernameValidator().validate(text)),
                  inputFormatters: [UsernameInputFormatter()],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(sizeLarge, 0, sizeLarge, 0),
              child: SizedBox(
                height: textFieldHeight,
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: string(context, 'label_password'),
                    hintStyle: TextStyle(fontSize: textFieldFontSize),
                    contentPadding: const EdgeInsets.fromLTRB(
                        0, textFieldContentPaddingT, 0, 0),
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          signInModel.obscurePassword =
                              !signInModel.obscurePassword;
                        });
                      },
                      child: Icon(signInModel.obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility),
                    ),
                  ),
                  style: TextStyle(fontSize: textFieldFontSize),
                  obscureText: signInModel.obscurePassword,
                  textInputAction: TextInputAction.done,
                  enableInteractiveSelection: false,
                  controller: _passwordController,
                  focusNode: _passwordFocusNode,
                  validator: (text) =>
                      string(context, PasswordValidator().validate(text)),
                  inputFormatters: [PasswordInputFormatter()],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, sizeNormal, 0, 0),
              child: ButtonBar(
                mainAxisSize: MainAxisSize.max,
                alignment: MainAxisAlignment.end,
                children: <Widget>[
                  ProgressButton(
                    defaultWidget: Text(string(context, 'label_sign_in')),
                    progressWidget: ThreeSizeDot(),
                    width: lrBtnWidth,
                    animate: false,
                    onPressed: () async {
                      FocusScope.of(context).unfocus();
                      if (_formKey.currentState.validate()) {
                        UserModel newUserModel = UserModel.create(
                            username: _usernameController.text,
                            password: _passwordController.text);
                        ParseResponse response = await newUserModel.signIn();
                        if (response.success) {
                          await Provider.of<UserModel>(context).init();
                        }
                        return () {
                          _passwordController.clear();
                          widget.onResponse(response);
                        };
                      } else {
                        return null;
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
