import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mall/core/util/localization/string_localization.dart';
import 'package:mall/features/backend/domain/entities/user_entity.dart';
import 'package:mall/features/backend/presentation/user_view_model.dart';
import 'package:mall/features/settings/presentation/util/settings_list_tile.dart';
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
          children: _buildSettingsList(context),
        ),
      ),
    );
  }

  List<Widget> _buildSettingsList(BuildContext context) {
    UserViewModel userViewModel = Provider.of<UserViewModel>(context);
    ThemeViewModel themeViewModel = Provider.of<ThemeViewModel>(context);

    var ret = List<Widget>();
    ret.addAll(_buildProfileList(context, userViewModel.getLastUser().type));
    ret.add(Divider());
    ret.add(buildThemeListTile(context, themeViewModel));
    ret.add(Divider());
    ret.add(buildSignOutListTile(context, userViewModel));
    return ret;
  }

  List<Widget> _buildProfileList(BuildContext context, UserType type) {
    var ret = List<Widget>();
    if (type == UserType.Anonymous) {
      ret.add(buildSignUpListTile(context));
    } else {
      ret.add(buildChangeDisplayImageListTile(context));
      ret.add(buildChangeUsernameListTile(context));
      ret.add(buildChangePasswordListTile(context));
      ret.add(buildChangeEmailAddressListTile(context));
    }
    return ret;
  }
}
