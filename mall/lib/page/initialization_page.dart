import 'package:flutter/material.dart';

class InitializationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _InitializationPageState();
}

class _InitializationPageState extends State<InitializationPage> {
  @override
  Widget build(BuildContext context) {
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
              onPressed: () {},
              child: Text("light"),
            ),
            RaisedButton(
              onPressed: () {},
              child: Text("dark"),
            ),
          ],
        ),
      ),
    );
  }
}
