import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:mall/src/core/core.dart';
import 'package:mall/src/models/models.dart';
import 'package:mall/src/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void dispose() {
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
    await Provider.of<ThemeModel>(context).init();

    await Parse().initialize(parseApplicationId, parseServerUrl,
        appName: parseApplicationName,
        masterKey: parseMasterKey,
        autoSendSessionId: true,
        coreStore: await CoreStoreSembastImp.getInstance(),
        debug: true);

    UserModel userModel = Provider.of<UserModel>(context);
    await userModel.init(fromServer: true);
    if (userModel.user == null) {
      locator<Nav>().router.navigateTo(context, 'AuthPage',
          clearStack: true, transition: TransitionType.fadeIn);
    } else {
      locator<Nav>().router.navigateTo(context, 'HomePage',
          clearStack: true, transition: TransitionType.fadeIn);
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
