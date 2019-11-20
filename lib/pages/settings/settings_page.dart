import 'package:fluro/fluro.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mall/constant.dart';
import 'package:mall/core/util/localization/string_localization.dart';
import 'package:mall/core/util/nav.dart';
import 'package:mall/features/theme/domain/entities/theme_entity.dart';
import 'package:mall/features/theme/presentation/theme_view_model.dart';
import 'package:mall/injection.dart';
import 'package:mall/models/user/user_model.dart';
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
      ListTile(
        title: Text(string(context, 'label_change_theme')),
        subtitle: Padding(
          padding: const EdgeInsets.fromLTRB(0, sizeLarge, 0, 0),
          child: ToggleButtons(
            children: _themeTypeWidgets(),
            onPressed: (int index) {
              Provider.of<ThemeViewModel>(context)
                  .setCurrentData(ThemeType.values[index], notify: true);
            },
            isSelected: _themeTypeSelectedStatus(
                Provider.of<ThemeViewModel>(context).getCurrentData().type),
          ),
        ),
      ),
    );
    ret.add(Divider());
    ret.add(
      ListTile(
        title: Text(string(context, 'label_sign_out')),
        onTap: () async {
          await userModel.signOut();
          locator<Nav>().router.navigateTo(context, 'AuthPage',
              clearStack: true, transition: TransitionType.fadeIn);
        },
      ),
    );
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
            locator<Nav>().router.navigateTo(
                context, 'ChangeDisplayPicturePage',
                transition: TransitionType.fadeIn);
          },
        ),
      );
      ret.add(
        ListTile(
          title: Text(string(context, 'label_change_username')),
          onTap: () {
            locator<Nav>().router.navigateTo(context, 'ChangeUsernamePage',
                transition: TransitionType.fadeIn);
          },
        ),
      );
      ret.add(
        ListTile(
          title: Text(string(context, 'label_change_password')),
          onTap: () {
            locator<Nav>().router.navigateTo(context, 'ChangePasswordPage',
                transition: TransitionType.fadeIn);
          },
        ),
      );
      ret.add(
        ListTile(
          title: Text(string(context, 'label_change_email_address')),
          onTap: () {
            locator<Nav>().router.navigateTo(context, 'ChangeEmailPage',
                transition: TransitionType.fadeIn);
          },
        ),
      );
    }
    return ret;
  }
}
