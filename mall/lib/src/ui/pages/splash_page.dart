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
    await Future.delayed(const Duration(milliseconds: 1000));
    Navigator.of(context).pushReplacementNamed('/AuthenticationPage');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ThreeBounce(
              widgetBuilder: (_, int index) {
                return DecoratedBox(
                  decoration: BoxDecoration(
                    color: [Colors.red, Colors.green, Colors.blue][index],
                    shape: BoxShape.circle,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
