import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';
import 'package:mall/src/core/constant.dart';
import 'package:mall/src/core/locator.dart';
import 'package:mall/src/models/auth/sign_up_model.dart';
import 'package:mall/src/models/user/user_model.dart';
import 'package:mall/src/utils/utils.dart';
import 'package:mall/src/widgets/text_editing_controller_workaround.dart';
import 'package:mall/src/widgets/three_size_dot.dart';
import 'package:mall/src/widgets/validation/validation.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  SignUpModel signUpModel = SignUpModel();
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
    super.dispose();
    signUpModel.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _repeatPasswordController.dispose();
    _emailAddressController.dispose();
    _usernameFocusNode.dispose();
    _passwordFocusNode.dispose();
    _repeatPasswordFocusNode.dispose();
    _emailAddressFocusNode.dispose();
    print('#### _SignUpPageState - dispose');
  }

  @override
  void initState() {
    super.initState();
    print('#### _SignUpPageState - initState');

    _usernameController.addListener(() {
      signUpModel.username = _usernameController.text;
    });
    _passwordController.addListener(() {
      signUpModel.password = _passwordController.text;
    });
    _repeatPasswordController.addListener(() {
      signUpModel.repeatPassword = _repeatPasswordController.text;
    });
    _emailAddressController.addListener(() {
      signUpModel.emailAddress = _emailAddressController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('#### _SignUpPageState - build');

    _usernameController.setTextAndPosition(signUpModel.username);
    _passwordController.setTextAndPosition(signUpModel.password);
    _repeatPasswordController.setTextAndPosition(signUpModel.repeatPassword);
    _emailAddressController.setTextAndPosition(signUpModel.emailAddress);

    return Scaffold(
      appBar: AppBar(
        title: Text(string(context, 'title_sign_up_page')),
        actions: <Widget>[
          Builder(
            builder: (context) => ProgressButton(
              defaultWidget: Text(string(context, 'label_sign_up')),
              progressWidget: ThreeSizeDot(),
              width: actionBtnWidth,
              animate: false,
              // ignore: missing_return
              onPressed: () async {
                FocusScope.of(context).unfocus();
                if (_formKey.currentState.validate()) {
                  UserModel newUserModel = UserModel.create(
                      username: _usernameController.text,
                      password: _passwordController.text,
                      emailAddress: _emailAddressController.text);
                  ParseResponse response = await newUserModel.signUp();
                  if (response.success) {
                    UserModel userModel = Provider.of<UserModel>(context);
                    if (userModel.hasUser()) {
                      await userModel.signOut();
                    }
                    await newUserModel.signIn();
                    newUserModel.type = UserType.Master; // TODO:
                    await newUserModel.save();
                    await newUserModel.pin();
                    await userModel.init();
                  }
                  return () {
                    _passwordController.clear();
                    _repeatPasswordController.clear();

                    if (response.success) {
                      locator<Nav>().router.pop(context);
                    } else {
                      showSimpleSnackBar(context, response.error.message);
                    }
                  };
                }
              },
            ),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding:
                          const EdgeInsets.fromLTRB(sizeLarge, 0, sizeLarge, 0),
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
                          onFieldSubmitted: (_) => FocusScope.of(context)
                              .requestFocus(_passwordFocusNode),
                          validator: (text) => string(
                              context, UsernameValidator().validate(text)),
                          inputFormatters: [UsernameInputFormatter()],
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.fromLTRB(sizeLarge, 0, sizeLarge, 0),
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
                          validator: (text) => string(
                              context, PasswordValidator().validate(text)),
                          inputFormatters: [PasswordInputFormatter()],
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.fromLTRB(sizeLarge, 0, sizeLarge, 0),
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
                      padding:
                          const EdgeInsets.fromLTRB(sizeLarge, 0, sizeLarge, 0),
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
                          validator: (text) => string(
                              context, EmailAddressValidator().validate(text)),
                          inputFormatters: [EmailAddressInputFormatter()],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
