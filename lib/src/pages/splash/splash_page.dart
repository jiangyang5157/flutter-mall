import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:mall/src/pages/pages.dart';
import 'package:mall/src/models/models.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    AppModel appModel = Provider.of<AppModel>(context);
    AuthModel authModel = Provider.of<AuthModel>(context);
    UserModel userModel = Provider.of<UserModel>(context);
    print('#### _SplashPageState build');

    return ChangeNotifierProvider<AppModel>(
      builder: (_) => appModel,
      child: appModel.initialized
          ? LandingPage()
          : Container(), // Stay here if app is not initialized.
    );
  }
}
