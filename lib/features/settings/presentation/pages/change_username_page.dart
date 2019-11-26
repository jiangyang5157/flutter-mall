import 'package:fluro/fluro.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';
import 'package:mall/core/constant.dart';
import 'package:mall/core/injection.dart';
import 'package:mall/core/util/localization/string_localization.dart';
import 'package:mall/core/util/nav.dart';
import 'package:mall/core/util/validation/username_input_formatter.dart';
import 'package:mall/core/util/validation/username_validator.dart';
import 'package:mall/core/util/widgets/ext.dart';
import 'package:mall/core/util/widgets/text_editing_controller_workaround.dart';
import 'package:mall/core/util/widgets/three_size_dot.dart';
import 'package:mall/features/backend/data/models/user_model.dart';
import 'package:mall/features/backend/presentation/user_view_model.dart';
import 'package:provider/provider.dart';

class ChangeUsernamePage extends StatefulWidget {
  ChangeUsernamePage({Key key}) : super(key: key);

  @override
  _ChangeUsernamePageState createState() => _ChangeUsernamePageState();
}

class _ChangeUsernamePageState extends State<ChangeUsernamePage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _usernameBefore;

  final TextEditingControllerWorkaround _usernameController =
      TextEditingControllerWorkaround();

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
    print('#### _ChangeUsernamePageState - dispose');
  }

  @override
  void initState() {
    super.initState();
    print('#### _ChangeUsernamePageState - initState');
  }

  @override
  Widget build(BuildContext context) {
    print('#### _ChangeUsernamePageState - build');

    UserViewModel userViewModel = Provider.of<UserViewModel>(context);
    UserModel userModel = userViewModel.getCurrentData();
    if (_usernameBefore == null) {
      _usernameBefore = userModel.name;
      _usernameController.setTextAndPosition(_usernameBefore);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(string(context, 'title_change_username_page')),
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
                            hintText: string(context, 'label_username'),
                            hintStyle: TextStyle(fontSize: textFieldFontSize),
                            contentPadding: const EdgeInsets.fromLTRB(
                                0, textFieldContentPaddingT, 0, 0),
                            prefixIcon: Icon(Icons.person),
                          ),
                          style: TextStyle(fontSize: textFieldFontSize),
                          textInputAction: TextInputAction.next,
                          controller: _usernameController,
                          validator: (text) => string(
                              context, UsernameValidator().validate(text)),
                          inputFormatters: [UsernameInputFormatter()],
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
                                await userViewModel
                                    .setName(_usernameController.text);
                                final failure = await userViewModel.save();
                                if (failure != null) {
                                  userViewModel.setName(_usernameBefore);
                                }
                                return () {
                                  if (failure == null) {
                                    locator<Nav>().router.navigateTo(
                                        context, 'HomePage',
                                        clearStack: true,
                                        transition: TransitionType.fadeIn);
                                  } else {
                                    showSimpleSnackBar(Scaffold.of(context),
                                        failure.toString());
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
