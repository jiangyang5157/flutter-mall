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
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 16.0),
                  child: Text(
                    string(context, 'title_sign_up_form'),
                    style: Theme.of(context).textTheme.title,
                  ),
                ),
                Container(
                  height: textFieldHeight,
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: string(context, 'label_username'),
                      contentPadding: const EdgeInsets.all(textFieldContentPadding),
                      prefixIcon: Icon(Icons.person),
                    ),
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
                Container(
                  height: textFieldHeight,
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: string(context, 'label_password'),
                      contentPadding: const EdgeInsets.all(textFieldContentPadding),
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
                    obscureText: signUpModel.obscurePassword,
                    textInputAction: TextInputAction.next,
                    enableInteractiveSelection: false,
                    controller: _passwordController,
                    focusNode: _passwordFocusNode,
                    onFieldSubmitted: (_) => FocusScope.of(context)
                        .requestFocus(_emailAddressFocusNode),
                    validator: (text) =>
                        string(context, PasswordValidator().validate(text)),
                    inputFormatters: [PasswordInputFormatter()],
                  ),
                ),
                Container(
                  height: textFieldHeight,
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: string(context, 'label_email_address'),
                      contentPadding: const EdgeInsets.all(textFieldContentPadding),
                      prefixIcon: Icon(Icons.email),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.done,
                    controller: _emailAddressController,
                    focusNode: _emailAddressFocusNode,
                    validator: (text) =>
                        string(context, EmailAddressValidator().validate(text)),
                    inputFormatters: [EmailAddressInputFormatter()],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: FlatButton(
                        child: Text(
                          string(context, 'label_sign_in'),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        onPressed: () {
                          Provider.of<LoginModel>(context).state =
                              LoginState.SignIn;
                        },
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: ProgressButton(
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
                                  locator<Nav>().router.navigateTo(
                                      context, 'HomePage',
                                      clearStack: true,
                                      transition: TransitionType.fadeIn);
                                } else {
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text(response.error.message),
                                    duration: Duration(
                                        milliseconds:
                                            snackBarDurationInMilliseconds),
                                  ));
                                }
                              }
                            };
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
