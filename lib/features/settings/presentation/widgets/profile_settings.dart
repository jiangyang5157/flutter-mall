import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ProfileSettings extends StatefulWidget {
  ProfileSettings({Key key}) : super(key: key);

  @override
  _ProfileSettingsState createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  @override
  void dispose() {
    super.dispose();
    print('#### _ProfileSettingsState - dispose');
  }

  @override
  void initState() {
    super.initState();
    print('#### _ProfileSettingsState - initState');
  }

  @override
  Widget build(BuildContext context) {
    print('#### _ProfileSettingsState - build');

    return Container();
  }
}
