import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluro/fluro.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';

import 'package:mall/src/models/models.dart';
import 'package:mall/src/core/core.dart';
import 'package:mall/src/utils/utils.dart';
import 'package:mall/src/widgets/widgets.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserModel userModel = UserModel();

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

    return ChangeNotifierProvider<UserModel>(
      builder: (context) => userModel,
      child: Scaffold(
        appBar: AppBar(
          title: Text(string(context, 'title_home')),
        ),
        drawer: Drawer(
          child: ChangeNotifierProvider<DrawerModel>(
            builder: (context) => DrawerModel(),
            child: Consumer2<UserModel, DrawerModel>(
              builder: (context, userModel, drawerModel, _) {
                return ListView(
                  padding: const EdgeInsets.all(0),
                  children: _buildDrawerList(context, userModel, drawerModel),
                );
              },
            ),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildDrawerList(
      BuildContext context, UserModel userModel, DrawerModel drawerModel) {
    var ret = List<Widget>();
    ret.add(_buildDrawerHeader(context, userModel, drawerModel));
    switch (drawerModel.state) {
      case DrawerState.Menu:
        ret.addAll(_buildDrawerMenu(context, userModel));
        break;
      case DrawerState.AccountDetails:
        ret.addAll(_buildDrawerAccountDetails(context, userModel));
        break;
    }
    return ret;
  }

  Widget _buildDrawerHeader(
      BuildContext context, UserModel userModel, DrawerModel drawerModel) {
    // TODO: why email address didn't update after changed email address?
    return UserAccountsDrawerHeader(
      accountName: Text(userModel.user.name),
      accountEmail: Text(userModel.user.emailAddress),
      currentAccountPicture: GestureDetector(
        child: CircleAvatar(
          backgroundColor: Colors.white,
        ),
      ),
      onDetailsPressed: () {
        print('${drawerModel.state}');
        switch (drawerModel.state) {
          case DrawerState.Menu:
            drawerModel.state = DrawerState.AccountDetails;
            break;
          case DrawerState.AccountDetails:
            drawerModel.state = DrawerState.Menu;
            break;
        }
      },
    );
  }

  List<Widget> _buildDrawerMenu(BuildContext context, UserModel userModel) {
    var ret = List<Widget>();
    ret.add(
      ListTile(
        title: Text('Light'),
        trailing: Icon(Icons.brightness_high),
        onTap: () {
          Provider.of<ThemeModel>(context).typeIn.add(ThemeType.Light);
        },
      ),
    );
    ret.add(
      ListTile(
        title: Text('Dark'),
        trailing: Icon(Icons.brightness_low),
        onTap: () {
          Provider.of<ThemeModel>(context).typeIn.add(ThemeType.Dark);
        },
      ),
    );
    return ret;
  }

  List<Widget> _buildDrawerAccountDetails(
      BuildContext context, UserModel userModel) {
    var ret = List<Widget>();
    ret.add(
      ListTile(
        title: Text(string(context, 'label_upload_display_picture')),
        trailing: Icon(Icons.account_circle),
        onTap: () {
          todo(context);
        },
      ),
    );
    ret.add(
      ListTile(
        title: Text(string(context, 'label_change_username')),
        trailing: Icon(Icons.person),
        onTap: () {
          todo(context);
        },
      ),
    );
    ret.add(
      ListTile(
        title: Text(string(context, 'label_change_password')),
        trailing: Icon(Icons.lock),
        onTap: () {
          todo(context);
        },
      ),
    );
    ret.add(_buildDrawerEmailItem(context, userModel));
    ret.add(Divider());
    ret.add(
      ListTile(
        title: Text(string(context, 'label_sign_out')),
        trailing: Icon(Icons.transit_enterexit),
        onTap: () async {
          UserModel(userModel.user).signOut();
          locator<Nav>().router.navigateTo(context, 'LoginPage',
              clearStack: true, transition: TransitionType.fadeIn);
        },
      ),
    );
    return ret;
  }

  Widget _buildDrawerEmailItem(BuildContext context, UserModel userModel) {
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final _emailAddressController = TextEditingControllerWorkaround();
    return ListTile(
      title: Text(string(context, 'label_change_email_address')),
      trailing: Icon(Icons.email),
      onTap: () {
        showSimpleAlertDialog(
          context,
          string(context, 'label_change_email_address'),
          <Widget>[
            Form(
              key: _formKey,
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
                  validator: (text) =>
                      string(context, EmailAddressValidator().validate(text)),
                  inputFormatters: [EmailAddressInputFormatter()],
                ),
              ),
            ),
          ],
          <Widget>[
            ProgressButton(
              defaultWidget: Text(
                string(context, 'label_confirm'),
                style: TextStyle(
                  color: Theme.of(context).buttonTheme.colorScheme.onPrimary,
                ),
              ),
              progressWidget: ThreeSizeDot(),
              width: 96,
              animate: false,
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  userModel.user.emailAddress = _emailAddressController.text;
                  ParseResponse response = await userModel.save();
                  return () {
                    if (mounted) {
                      if (response.success) {
                        showSimpleSnackBar(
                            context, string(context, 'label_success'));
                      } else {
                        showSimpleSnackBar(context, response.error.message);
                      }
                    }
                  };
                }
              },
            ),
          ],
        );
      },
    );
  }
}
