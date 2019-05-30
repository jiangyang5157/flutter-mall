import 'dart:async';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    todo();
  }

  Future todo() async {
    await new Future.delayed(const Duration(seconds: 1));
    Navigator.of(context).pushReplacementNamed("/AuthenticationPage");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("TODO splash screen animation"),
          ],
        ),
      ),
    );
  }
}
