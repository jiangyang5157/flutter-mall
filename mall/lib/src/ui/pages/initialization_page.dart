import 'package:flutter/material.dart';

import 'package:mall/src/blocs/blocs.dart';

class InitializationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _InitializationPageState();
}

class _InitializationPageState extends State<InitializationPage> {
  @override
  Widget build(BuildContext context) {
    final ApplicationBloc appBloc = BlocProvider.of<ApplicationBloc>(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("TODO"),
            RaisedButton(
              onPressed: () {},
              child: Text("en"),
            ),
            RaisedButton(
              onPressed: () {},
              child: Text("zh"),
            ),
            RaisedButton(
              onPressed: () {
                appBloc.inDarkTheme.add(false);
              },
              child: Text("light"),
            ),
            RaisedButton(
              onPressed: () {
                appBloc.inDarkTheme.add(true);
              },
              child: Text("dark"),
            ),
          ],
        ),
      ),
    );
  }
}
