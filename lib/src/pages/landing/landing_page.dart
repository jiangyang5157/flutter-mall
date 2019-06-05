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
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthModel>(builder: (context, authModel, _) {
      switch (authModel.authState) {
        case AuthState.Unauthenticated:
          return LoginPage();
        case AuthState.Authenticated:
          return HomePage();
      }
    });
  }
}
