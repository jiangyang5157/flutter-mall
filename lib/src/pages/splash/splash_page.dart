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
  AuthModel authModel;
  UserModel userModel;

  @override
  void initState() {
    authModel = AuthModel();
    userModel = UserModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppModel  appModel = Provider.of<AppModel>(context);
    print('#### _SplashPageState build');

    return ChangeNotifierProvider<AppModel>(
      builder: (_) => appModel,
      child: appModel.initialized
          ? MultiProvider(
              providers: [
                Provider<AuthModel>.value(value: authModel),
                Provider<UserModel>.value(value: userModel),
              ],
              child: LandingPage(),
            )
          : Container(), // Stay here if app is not initialized.
    );
  }
}
