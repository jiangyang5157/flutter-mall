import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
    var ret = List<Widget>();
    ret.addAll(_buildProfileList(context));
    ret.add(Divider());
//    ret.add(ToggleButtons());
    return ret;
  }

  List<Widget> _buildProfileList(BuildContext context) {
    var ret = List<Widget>();
    UserModel userModel = Provider.of<UserModel>(context);
    if (userModel.type == UserType.Anonymous) {
      ret.add(
        ListTile(
          title: Text(string(context, 'label_create_account')),
          onTap: () {
            todo(context);
          },
        ),
      );
    } else {
      ret.add(
        ListTile(
          title: Text(string(context, 'label_upload_display_picture')),
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
          title: Text(string(context, 'label_update_email_address')),
          onTap: () {
            todo(context);
          },
        ),
      );
    }
    return ret;
  }
}