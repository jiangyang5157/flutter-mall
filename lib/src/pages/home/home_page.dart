import 'package:fluro/fluro.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mall/src/core/core.dart';
import 'package:mall/src/models/models.dart';
import 'package:mall/src/utils/utils.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void dispose() {
    super.dispose();
    print('#### _HomePageState - dispose');
  }

  @override
  void initState() {
    super.initState();
    print('#### _HomePageState - initState');
  }

  @override
  Widget build(BuildContext context) {
    print('#### _HomePageState build');

    return Scaffold(
      appBar: AppBar(
        title: Text(string(context, 'title_home')),
      ),
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: _buildDrawerList(context),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[],
        ),
      ),
    );
  }

  List<Widget> _buildDrawerList(BuildContext context) {
    var ret = List<Widget>();
    ret.add(_buildDrawerHeader(context));
    ret.addAll(_buildDrawerMenu(context));
    return ret;
  }

  Widget _buildDrawerHeader(BuildContext context) {
    UserModel userModel = Provider.of<UserModel>(context);
    return UserAccountsDrawerHeader(
      accountName: Text(userModel.name),
      accountEmail: Text(userModel.emailAddress ?? ''),
      currentAccountPicture: GestureDetector(
        child: CircleAvatar(
          backgroundColor: Colors.white,
        ),
      ),
    );
  }

  List<Widget> _buildDrawerMenu(BuildContext context) {
    var ret = List<Widget>();
    ret.add(Divider());
    ret.add(
      ListTile(
        title: Text(string(context, 'label_settings')),
        trailing: Icon(Icons.settings),
        onTap: () async {
          locator<Nav>().router.pop(context);
          locator<Nav>().router.navigateTo(context, 'SettingsPage',
              transition: TransitionType.fadeIn);
        },
      ),
    );
    UserModel userModel = Provider.of<UserModel>(context);
    ret.add(
      ListTile(
        title: Text(string(context, 'label_sign_out')),
        onTap: () async {
          if (userModel.type == UserType.Anonymous) {
            userModel.destroy();
            userModel.signOut();
          } else {
            userModel.signOut();
          }
          locator<Nav>().router.navigateTo(context, 'AuthPage',
              clearStack: true, transition: TransitionType.fadeIn);
        },
      ),
    );
    return ret;
  }

//  import 'package:parse_server_sdk/parse_server_sdk.dart';
//  import 'package:flutter_progress_button/flutter_progress_button.dart';
//  import 'package:mall/src/widgets/widgets.dart';
//  Widget _buildDrawerEmailItem(BuildContext context, UserModel userModel) {
//    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//    final _emailAddressController = TextEditingControllerWorkaround();
//    return ListTile(
//      title: Text(string(context, 'label_change_email_address')),
//      trailing: Icon(Icons.email),
//      onTap: () {
//        showSimpleAlertDialog(
//          context,
//          string(context, 'label_change_email_address'),
//          <Widget>[
//            Form(
//              key: _formKey,
//              child: SizedBox(
//                height: textFieldHeight,
//                child: TextFormField(
//                  decoration: InputDecoration(
//                    hintText: string(context, 'label_email_address'),
//                    hintStyle: TextStyle(fontSize: textFieldFontSize),
//                    contentPadding: const EdgeInsets.fromLTRB(
//                        0, textFieldContentPaddingT, 0, 0),
//                    prefixIcon: Icon(Icons.email),
//                  ),
//                  style: TextStyle(fontSize: textFieldFontSize),
//                  keyboardType: TextInputType.emailAddress,
//                  textInputAction: TextInputAction.done,
//                  controller: _emailAddressController,
//                  validator: (text) =>
//                      string(context, EmailAddressValidator().validate(text)),
//                  inputFormatters: [EmailAddressInputFormatter()],
//                ),
//              ),
//            ),
//          ],
//          <Widget>[
//            ProgressButton(
//              defaultWidget: Text(
//                string(context, 'label_confirm'),
//                style: TextStyle(
//                  color: Theme.of(context).buttonTheme.colorScheme.onPrimary,
//                ),
//              ),
//              progressWidget: ThreeSizeDot(),
//              width: 96,
//              animate: false,
//              onPressed: () async {
//                if (_formKey.currentState.validate()) {
//                  UserModel tmpUserModel = UserModel();
//                  await tmpUserModel.init();
//                  tmpUserModel.emailAddress = _emailAddressController.text;
//                  ParseResponse response = await tmpUserModel.save();
//                  return () {
//                    if (mounted) {
//                      if (response.success) {
//                        userModel.emailAddress = tmpUserModel.emailAddress;
//                        showSimpleSnackBar(
//                            context, string(context, 'label_success'));
//                      } else {
//                        showSimpleSnackBar(context, response.error.message);
//                      }
//                    }
//                  };
//                }
//              },
//            ),
//          ],
//        );
//      },
//    );
//  }
}
