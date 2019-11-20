import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';
import 'package:mall/constant.dart';
import 'package:mall/core/util/localization/string_localization.dart';
import 'package:mall/core/util/validation/password_input_formatter.dart';
import 'package:mall/core/util/validation/password_validator.dart';
import 'package:mall/core/util/validation/username_input_formatter.dart';
import 'package:mall/core/util/validation/username_validator.dart';
import 'package:mall/core/util/widgets/text_editing_controller_workaround.dart';
import 'package:mall/core/util/widgets/three_size_dot.dart';
import 'package:mall/features/signin/presentation/sign_in_view_model.dart';
import 'package:mall/models/user_model.dart';
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

  final TextEditingControllerWorkaround _usernameController =
      TextEditingControllerWorkaround();
  final TextEditingControllerWorkaround _passwordController =
      TextEditingControllerWorkaround();
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
      Provider.of<SignInViewModel>(context)
          .setUsername(_usernameController.text, notify: false);
    });
    _passwordController.addListener(() {
      Provider.of<SignInViewModel>(context)
          .setPassword(_passwordController.text, notify: false);
    });
  }

  @override
  Widget build(BuildContext context) {
    print('#### _SignInFormState - build');

    SignInViewModel signInViewModel = Provider.of<SignInViewModel>(context);
    _usernameController
        .setTextAndPosition(signInViewModel.getCurrentData().username);
    _passwordController
        .setTextAndPosition(signInViewModel.getCurrentData().password);

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
                        signInViewModel.setObscurePassword(
                            !signInViewModel.getCurrentData().obscurePassword,
                            notify: false);
                      });
                    },
                    child: Icon(signInViewModel.getCurrentData().obscurePassword
                        ? Icons.visibility_off
                        : Icons.visibility),
                  ),
                ),
                style: TextStyle(fontSize: textFieldFontSize),
                obscureText: signInViewModel.getCurrentData().obscurePassword,
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
                        await Provider.of<UserModel>(context).sync();
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
    );
  }
}
