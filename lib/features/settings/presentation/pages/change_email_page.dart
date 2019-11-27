import 'package:fluro/fluro.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';
import 'package:mall/core/constant.dart';
import 'package:mall/core/injection.dart';
import 'package:mall/core/util/localization/string_localization.dart';
import 'package:mall/core/util/nav.dart';
import 'package:mall/core/util/validation/email_address_input_formatter.dart';
import 'package:mall/core/util/validation/email_address_validator.dart';
import 'package:mall/core/util/widgets/ext.dart';
import 'package:mall/core/util/widgets/text_editing_controller_workaround.dart';
import 'package:mall/core/util/widgets/three_size_dot.dart';
import 'package:mall/features/backend/data/models/user_model.dart';
import 'package:mall/features/backend/presentation/user_view_model.dart';
import 'package:provider/provider.dart';

class ChangeEmailPage extends StatefulWidget {
  ChangeEmailPage({Key key}) : super(key: key);

  @override
  _ChangeEmailPageState createState() => _ChangeEmailPageState();
}

class _ChangeEmailPageState extends State<ChangeEmailPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _emailAddressBefore;

  final TextEditingControllerWorkaround _emailAddressController =
      TextEditingControllerWorkaround();

  @override
  void dispose() {
    _emailAddressController.dispose();
    super.dispose();
    print('#### _ChangeEmailPageState - dispose');
  }

  @override
  void initState() {
    super.initState();
    print('#### _ChangeEmailPageState - initState');
  }

  @override
  Widget build(BuildContext context) {
    print('#### _ChangeEmailPageState - build');

    UserViewModel userViewModel = Provider.of<UserViewModel>(context);
    UserModel userModel = userViewModel.getLastUser();
    if (_emailAddressBefore == null) {
      _emailAddressBefore = userModel.emailAddress;
      _emailAddressController.setTextAndPosition(_emailAddressBefore);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(string(context, 'title_change_email_page')),
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
                          validator: (text) => string(
                              context, EmailAddressValidator().validate(text)),
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
                            defaultWidget:
                                Text(string(context, 'label_confirm')),
                            progressWidget: ThreeSizeDot(),
                            width: lrBtnWidth,
                            animate: false,
                            onPressed: () async {
                              FocusScope.of(context).unfocus();
                              if (_formKey.currentState.validate()) {
                                final failure =
                                    await userViewModel.setEmailAddress(
                                        _emailAddressController.text);
                                if (failure != null) {
                                  userViewModel
                                      .setEmailAddress(_emailAddressBefore);
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
