import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';
import 'package:mall/core/constant.dart';
import 'package:mall/core/error/failures.dart';
import 'package:mall/core/util/localization/string_localization.dart';
import 'package:mall/core/util/validation/email_address_input_formatter.dart';
import 'package:mall/core/util/validation/email_address_validator.dart';
import 'package:mall/core/util/validation/password_input_formatter.dart';
import 'package:mall/core/util/validation/password_validator.dart';
import 'package:mall/core/util/validation/repeat_password_validator.dart';
import 'package:mall/core/util/validation/username_input_formatter.dart';
import 'package:mall/core/util/validation/username_validator.dart';
import 'package:mall/core/util/widgets/text_editing_controller_workaround.dart';
import 'package:mall/core/util/widgets/three_size_dot.dart';
import 'package:mall/features/backend/domain/entities/user_entity.dart';
import 'package:mall/features/backend/presentation/user_view_model.dart';
import 'package:mall/features/signup/presentation/sign_up_view_model.dart';
import 'package:provider/provider.dart';

class SignUpForm extends StatefulWidget {
  final Function(Failure failure) onSubmitted;

  SignUpForm({Key key, @required this.onSubmitted}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingControllerWorkaround _usernameController =
      TextEditingControllerWorkaround();
  final TextEditingControllerWorkaround _passwordController =
      TextEditingControllerWorkaround();
  final TextEditingControllerWorkaround _repeatPasswordController =
      TextEditingControllerWorkaround();
  final TextEditingControllerWorkaround _emailAddressController =
      TextEditingControllerWorkaround();
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
      Provider.of<SignUpViewModel>(context)
          .setUsername(_usernameController.text);
    });
    _passwordController.addListener(() {
      Provider.of<SignUpViewModel>(context)
          .setPassword(_passwordController.text);
    });
    _repeatPasswordController.addListener(() {
      Provider.of<SignUpViewModel>(context)
          .setRepeatPassword(_repeatPasswordController.text);
    });
    _emailAddressController.addListener(() {
      Provider.of<SignUpViewModel>(context)
          .setEmailAddress(_emailAddressController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    print('#### _SignUpFormState - build');

    SignUpViewModel signUpViewModel = Provider.of<SignUpViewModel>(context);
    _usernameController
        .setTextAndPosition(signUpViewModel.getLastData().username);
    _passwordController
        .setTextAndPosition(signUpViewModel.getLastData().password);
    _repeatPasswordController
        .setTextAndPosition(signUpViewModel.getLastData().repeatPassword);
    _emailAddressController
        .setTextAndPosition(signUpViewModel.getLastData().emailAddress);

    return Form(
      key: _formKey,
      child: Column(
        children: [
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
                        signUpViewModel.setObscurePassword(
                            !signUpViewModel.getLastData().obscurePassword);
                      });
                    },
                    child: Icon(signUpViewModel.getLastData().obscurePassword
                        ? Icons.visibility_off
                        : Icons.visibility),
                  ),
                ),
                style: TextStyle(fontSize: textFieldFontSize),
                obscureText: signUpViewModel.getLastData().obscurePassword,
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
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_emailAddressFocusNode),
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
                      UserViewModel userViewModel =
                          Provider.of<UserViewModel>(context);
                      final failure = await userViewModel.signUp(
                          type: _usernameController.text ==
                                  typeToString(UserType.Master)
                              ? UserType.Master
                              : UserType.Normal,
                          username: _usernameController.text,
                          password: _passwordController.text,
                          emailAddress: _emailAddressController.text);
                      return () {
                        _passwordController.clear();
                        _repeatPasswordController.clear();
                        widget.onSubmitted(failure);
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
    );
  }
}
