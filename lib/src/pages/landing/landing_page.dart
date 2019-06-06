import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:mall/src/pages/login/login.dart';
import 'package:mall/src/models/models.dart';
import 'package:mall/src/pages/pages.dart';

class LandingPage extends StatefulWidget {
  LandingPage({Key key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    print('#### _LandingPageState build');
    AuthModel authModel = Provider.of<AuthModel>(context);

    return ChangeNotifierProvider<AuthModel>(
      builder: (_) => authModel,
      child: Consumer<AuthModel>(builder: (context, model, _) {
        switch (model.authState) {
          case AuthState.Unauthenticated:
            return LoginPage();
          case AuthState.Authenticated:
            return HomePage();
        }
      }),
    );
  }
}
