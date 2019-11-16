import 'package:fluro/fluro.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';
import 'package:mall/constant.dart';
import 'package:mall/core/util/localization/string_localization.dart';
import 'package:mall/core/util/nav.dart';
import 'package:mall/core/util/validation/password_input_formatter.dart';
import 'package:mall/core/util/validation/password_validator.dart';
import 'package:mall/core/util/validation/repeat_password_validator.dart';
import 'package:mall/core/util/widgets/ext.dart';
import 'package:mall/core/util/widgets/text_editing_controller_workaround.dart';
import 'package:mall/core/util/widgets/three_size_dot.dart';
import 'package:mall/injection.dart';
import 'package:mall/models/user/user_model.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:provider/provider.dart';

class ChangePasswordPage extends StatefulWidget {
  ChangePasswordPage({Key key}) : super(key: key);

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _passwordBefore;
  bool _obscurePassword = true;

  final TextEditingControllerWorkaround _passwordController =
      TextEditingControllerWorkaround();
  final TextEditingControllerWorkaround _repeatPasswordController =
      TextEditingControllerWorkaround();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _repeatPasswordFocusNode = FocusNode();

  @override
  void dispose() {
    _passwordController.dispose();
    _repeatPasswordController.dispose();
    _passwordFocusNode.dispose();
    _repeatPasswordFocusNode.dispose();
    super.dispose();
    print('#### _ChangePasswordPageState - dispose');
  }

  @override
  void initState() {
    super.initState();
    print('#### _ChangePasswordPageState - initState');
  }

  @override
  Widget build(BuildContext context) {
    print('#### _ChangePasswordPageState - build');

    UserModel userModel = Provider.of<UserModel>(context);
    if (_passwordBefore == null) {
      _passwordBefore = userModel.password;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(string(context, 'title_change_password_page')),
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
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                          sizeLarge, sizeLarge, sizeLarge, 0),
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
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                              child: Icon(_obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                            ),
                          ),
                          style: TextStyle(fontSize: textFieldFontSize),
                          obscureText: _obscurePassword,
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
                          validator: (text) => string(
                              context,
                              RepeatPasswordValidator(_passwordController.text)
                                  .validate(text)),
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
                            defaultWidget:
                                Text(string(context, 'label_confirm')),
                            progressWidget: ThreeSizeDot(),
                            width: lrBtnWidth,
                            animate: false,
                            onPressed: () async {
                              FocusScope.of(context).unfocus();
                              if (_formKey.currentState.validate()) {
                                userModel.password = _passwordController.text;
                                ParseResponse response = await userModel.save();
                                if (!response.success) {
                                  userModel.password = _passwordBefore;
                                }
                                return () {
                                  _passwordController.clear();
                                  _repeatPasswordController.clear();

                                  if (response.success) {
                                    locator<Nav>().router.navigateTo(
                                        context, 'HomePage',
                                        clearStack: true,
                                        transition: TransitionType.fadeIn);
                                  } else {
                                    showSimpleSnackBar(Scaffold.of(context),
                                        response.error.message);
                                  }
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
            ),
          );
        },
      ),
    );
  }
}
