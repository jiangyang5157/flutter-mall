import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:mall/src/core/core.dart';
import 'package:mall/src/models/models.dart';
import 'package:mall/src/utils/utils.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  InitModel initModel = InitModel();
  UserModel userModel = UserModel();

  @override
  void dispose() {
    initModel.dispose();
    userModel.dispose();
    super.dispose();
    print('#### _SplashPageState - dispose');
  }

  @override
  void initState() {
    super.initState();
    print('#### _SplashPageState - initState');
    _init();
  }

  Future<void> _init() async {
    await initModel.init();
    switch (initModel.state) {
      case InitState.Start:
        // ignore: wait for InitState.Finish
        break;
      case InitState.Finish:
        await userModel.init(fromServer: true);
        if (userModel.user == null) {
          locator<Nav>().router.navigateTo(context, 'AuthPage',
              clearStack: true, transition: TransitionType.fadeIn);
        } else {
          locator<Nav>().router.navigateTo(context, 'HomePage',
              clearStack: true, transition: TransitionType.fadeIn);
        }
        break;
      default:
        throw ("${initModel.state} is not recognized as an SplashState");
    }
  }

  @override
  Widget build(BuildContext context) {
    print('#### _SplashPageState - build');
    return Scaffold(
        // TODO:
        );
  }
}
