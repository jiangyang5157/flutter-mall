import 'dart:async';
import 'package:flutter/material.dart';

import 'package:mall/src.dart';

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
    await Future.delayed(const Duration(milliseconds: 2000));
    Navigator.of(context).pushReplacementNamed('/AuthenticationPage');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ThreeBounceDot(
                shape: BoxShape.circle
            ),
            ThreeSizeDot(
                shape: BoxShape.circle
            ),
            ThreeBounceDot(
                shape: BoxShape.rectangle
            ),
            ThreeSizeDot(
                shape: BoxShape.rectangle
            ),
          ],
        ),
      ),
    );
  }
}
