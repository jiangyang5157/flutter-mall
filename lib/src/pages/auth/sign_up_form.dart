import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';
import 'package:mall/src/core/core.dart';
import 'package:mall/src/models/models.dart';
import 'package:mall/src/utils/utils.dart';
import 'package:mall/src/widgets/widgets.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:provider/provider.dart';

class SignUpForm extends StatefulWidget {
  final Function(ParseResponse response) onResponse;

  SignUpForm({Key key, @required this.onResponse}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingControllerWorkaround();
  final _passwordController = TextEditingControllerWorkaround();
  final _repeatPasswordController = TextEditingControllerWorkaround();
  final _emailAddressController = TextEditingControllerWorkaround();
  final FocusNode _usernameFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _repeatPasswordFocusNode = FocusNode();
  final FocusNode _emailAddressFocusNode = FocusNode();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _repeatPasswordController.dispose();
    _emailAddressController.dispose();
    _usernameFocusNode.dispose();
    _passwordFocusNode.dispose();
    _repeatPasswordFocusNode.dispose();
    _emailAddressFocusNode.dispose();
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
    _repeatPasswordController.addListener(() {
      Provider.of<SignUpModel>(context).repeatPassword =
          _repeatPasswordController.text;
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
    _repeatPasswordController.setTextAndPosition(signUpModel.repeatPassword);
    _emailAddressController.setTextAndPosition(signUpModel.emailAddress);

    return Card(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, sizeLarge, 0, 0),
              child: Text(
                string(context, 'title_sign_up_form'),
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
                          signUpModel.obscurePassword =
                              !signUpModel.obscurePassword;
                        });
                      },
                      child: Icon(signUpModel.obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility),
                    ),
                  ),
                  style: TextStyle(fontSize: textFieldFontSize),
                  obscureText: signUpModel.obscurePassword,
                  textInputAction: TextInputAction.next,
                  enableInteractiveSelection: false,
                  controller: _passwordController,
                  focusNode: _passwordFocusNode,
                  onFieldSubmitted: (_) => FocusScope.of(context)
                      .requestFocus(_repeatPasswordFocusNode),
                  validator: (text) =>
                      string(context, PasswordValidator().validate(text)),
                  inputFormatters: [PasswordInputFormatter()],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(sizeLarge, 0, sizeLarge, 0),
              child: SizedBox(
                height: textFieldHeight,
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: string(context, 'label_repeat_password'),
                    hintStyle: TextStyle(fontSize: textFieldFontSize),
                    contentPadding: const EdgeInsets.fromLTRB(
                        0, textFieldContentPaddingT, 0, 0),
                    prefixIcon: Icon(Icons.lock),
                  ),
                  style: TextStyle(fontSize: textFieldFontSize),
                  obscureText: true,
                  textInputAction: TextInputAction.next,
                  enableInteractiveSelection: false,
                  controller: _repeatPasswordController,
                  focusNode: _repeatPasswordFocusNode,
                  onFieldSubmitted: (_) => FocusScope.of(context)
                      .requestFocus(_emailAddressFocusNode),
                  validator: (text) => string(
                      context,
                      RepeatPasswordValidator(_passwordController.text)
                          .validate(text)),
                  inputFormatters: [PasswordInputFormatter()],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(sizeLarge, 0, sizeLarge, 0),
              child: SizedBox(
                height: textFieldHeight,
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: string(context, 'label_email_address'),
                    hintStyle: TextStyle(fontSize: textFieldFontSize),
                    contentPadding: const EdgeInsets.fromLTRB(
                        0, textFieldContentPaddingT, 0, 0),
                    prefixIcon: Icon(Icons.email),
                  ),
                  style: TextStyle(fontSize: textFieldFontSize),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  controller: _emailAddressController,
                  focusNode: _emailAddressFocusNode,
                  validator: (text) =>
                      string(context, EmailAddressValidator().validate(text)),
                  inputFormatters: [EmailAddressInputFormatter()],
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
                    defaultWidget: Text(string(context, 'label_sign_up')),
                    progressWidget: ThreeSizeDot(),
                    width: lrBtnWidth,
                    animate: false,
                    onPressed: () async {
                      FocusScope.of(context).unfocus();
                      if (_formKey.currentState.validate()) {
                        UserModel newUserModel = UserModel.create(
                            username: _usernameController.text,
                            password: _passwordController.text,
                            emailAddress: _emailAddressController.text);
                        ParseResponse response = await newUserModel.signUp();
                        if (response.success) {
                          await newUserModel.signIn();
                          newUserModel.type = UserType.Master; // TODO:
                          await newUserModel.save();
                          await newUserModel.pin();
                          await Provider.of<UserModel>(context).init();
                        }
                        return () {
                          _passwordController.clear();
                          _repeatPasswordController.clear();
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
