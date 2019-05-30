import 'package:flutter/material.dart';

import 'package:mall/src/app/app.dart';
import 'package:mall/src/blocs/blocs.dart';

class AuthenticationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  @override
  Widget build(BuildContext context) {
    final AppBloc appBloc = BlocProvider.of<AppBloc>(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(AppLocalization.of(context).string('appName')),
            RaisedButton(
              onPressed: () {
                appBloc.inDarkTheme.add(false);
              },
              child: Text('light'),
            ),
            RaisedButton(
              onPressed: () {
                appBloc.inDarkTheme.add(true);
              },
              child: Text('dark'),
            ),
          ],
        ),
      ),
    );
  }
}
