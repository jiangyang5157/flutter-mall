import 'package:fluro/fluro.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mall/core/constant.dart';
import 'package:mall/core/injection.dart';
import 'package:mall/core/util/localization/string_localization.dart';
import 'package:mall/core/util/nav.dart';
import 'package:mall/features/backend/data/models/user_model.dart';
import 'package:mall/features/backend/domain/entities/user_entity.dart';
import 'package:mall/features/backend/presentation/user_view_model.dart';
import 'package:mall/features/settings/presentation/util/settings_list_tile.dart';
import 'package:mall/features/theme/domain/entities/theme_entity.dart';
import 'package:mall/features/theme/presentation/theme_view_model.dart';
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
    UserViewModel userViewModel = Provider.of<UserViewModel>(context);
    UserModel userModel = userViewModel.getLastUser();
    var ret = List<Widget>();
    ret.addAll(_buildProfileList(context, userModel.type));
    ret.add(Divider());
    ret.add(buildThemeListTile(context, Provider.of<ThemeViewModel>(context)));
    ret.add(Divider());
    ret.add(
      ListTile(
        title: Text(string(context, 'label_sign_out')),
        onTap: () async {
          await userViewModel.signOut();
          locator<Nav>().router.navigateTo(context, 'AuthPage',
              clearStack: true, transition: TransitionType.fadeIn);
        },
      ),
    );
    return ret;
  }

  List<Widget> _buildProfileList(BuildContext context, UserType type) {
    var ret = List<Widget>();
    if (type == UserType.Anonymous) {
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
