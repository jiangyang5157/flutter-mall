import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppSettings extends StatefulWidget {
  AppSettings({Key key}) : super(key: key);

  @override
  _AppSettingsState createState() => _AppSettingsState();
}

class _AppSettingsState extends State<AppSettings> {
  @override
  void dispose() {
    super.dispose();
    print('#### _AppSettingsState - dispose');
  }

  @override
  void initState() {
    super.initState();
    print('#### _AppSettingsState - initState');
  }

  @override
  Widget build(BuildContext context) {
    print('#### _AppSettingsState - build');

    return Container();
  }
}
