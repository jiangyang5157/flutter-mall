import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluro/fluro.dart';

import 'package:mall/src/models/models.dart';
import 'package:mall/src/core/core.dart';
import 'package:mall/src/utils/utils.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserModel userModel = UserModel();

  @override
  void dispose() {
    super.dispose();
    print('#### _HomePageState - dispose');
  }

  @override
  void initState() {
    super.initState();
    print('#### _HomePageState - initState');
  }

  @override
  Widget build(BuildContext context) {
    print('#### _HomePageState build');

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserModel>(builder: (_) => userModel),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(string(context, 'title_home')),
        ),
        drawer: Drawer(
          child: ListView(
            padding: const EdgeInsets.all(0.0),
            children: <Widget>[
              Consumer<UserModel>(
                builder: (context, userModel, _) {
                  return UserAccountsDrawerHeader(
                    accountName: Text(userModel.user?.name ?? ''),
                    accountEmail: Text(userModel.user?.emailAddress ?? ''),
                    currentAccountPicture: GestureDetector(
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                title: Text('Light'),
                trailing: Icon(Icons.settings),
                onTap: () {
                  Provider.of<ThemeModel>(context).typeIn.add(ThemeType.Light);
                },
              ),
              ListTile(
                title: Text('Dark'),
                trailing: Icon(Icons.settings),
                onTap: () {
                  Provider.of<ThemeModel>(context).typeIn.add(ThemeType.Dark);
                },
              ),
              Divider(),
              ListTile(
                title: Text(string(context, 'label_sign_out')),
                trailing: Icon(Icons.settings),
                onTap: () async {
                  UserModel(userModel.user).signOut();
                  locator<Nav>().router.navigateTo(context, 'LoginPage',
                      clearStack: true, transition: TransitionType.fadeIn);
                },
              ),
            ],
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[],
          ),
        ),
      ),
    );
  }
}
