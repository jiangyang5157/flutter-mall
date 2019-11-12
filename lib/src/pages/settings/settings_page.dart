import 'package:fluro/fluro.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mall/src/core/constant.dart';
import 'package:mall/src/core/locator.dart';
import 'package:mall/src/models/models.dart';
import 'package:mall/src/utils/utils.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void dispose() {
    super.dispose();
    print('#### _SettingsPageState - dispose');
  }

  @override
  void initState() {
    super.initState();
    print('#### _SettingsPageState - initState');
  }

  @override
  Widget build(BuildContext context) {
    print('#### _SettingsPageState - build');

    return Scaffold(
      appBar: AppBar(
        title: Text(string(context, 'title_settings')),
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: (_buildSettingsList(context)),
        ),
      ),
    );
  }

  List<Widget> _buildSettingsList(BuildContext context) {
    UserModel userModel = Provider.of<UserModel>(context);
    var ret = List<Widget>();
    ret.addAll(_buildProfileList(context, userModel.type));
    ret.add(Divider());
    ret.add(
      Padding(
        padding: const EdgeInsets.fromLTRB(sizeLarge, 0, sizeLarge, 0),
        child: ToggleButtons(
          children: _themeTypeWidgets(),
          onPressed: (int index) {
            Provider.of<ThemeModel>(context).type = ThemeType.values[index];
          },
          isSelected:
              _themeTypeSelectedStatus(Provider.of<ThemeModel>(context).type),
        ),
      ),
    );
    ret.add(Divider());
    return ret;
  }

  List<Widget> _themeTypeWidgets() {
    var ret = List<Widget>();
    for (int i = 0; i < ThemeType.values.length; i++) {
      switch (ThemeType.values[i]) {
        case ThemeType.Light:
          ret.add(
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.brightness_high),
                SizedBox(width: sizeSmall),
                Text(string(context, 'label_light_theme')),
              ],
            ),
          );
          break;
        case ThemeType.Dark:
          ret.add(
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.brightness_low),
                SizedBox(width: sizeSmall),
                Text(string(context, 'label_dark_theme')),
              ],
            ),
          );
          break;
      }
    }
    return ret;
  }

  List<bool> _themeTypeSelectedStatus(ThemeType themeType) {
    var ret = List<bool>();
    for (int i = 0; i < ThemeType.values.length; i++) {
      if (ThemeType.values[i] == themeType) {
        ret.add(true);
      } else {
        ret.add(false);
      }
    }
    return ret;
  }

  List<Widget> _buildProfileList(BuildContext context, UserType userType) {
    var ret = List<Widget>();
    if (userType == UserType.Anonymous) {
      ret.add(
        ListTile(
          title: Text(string(context, 'title_sign_up_page')),
          onTap: () {
            locator<Nav>().router.navigateTo(context, 'SignUpPage',
                transition: TransitionType.fadeIn);
          },
        ),
      );
    } else {
      ret.add(
        ListTile(
          title: Text(string(context, 'label_change_display_picture')),
          onTap: () {
            todo(context);
          },
        ),
      );
      ret.add(
        ListTile(
          title: Text(string(context, 'label_change_username')),
          onTap: () {
            todo(context);
          },
        ),
      );
      ret.add(
        ListTile(
          title: Text(string(context, 'label_change_password')),
          onTap: () {
            todo(context);
          },
        ),
      );
      ret.add(
        ListTile(
          title: Text(string(context, 'label_change_email_address')),
          onTap: () {
            todo(context);
          },
        ),
      );
    }
    return ret;
  }
}
