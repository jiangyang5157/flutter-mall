import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:mall/src/models/models.dart';
import 'package:mall/src/core/core.dart';

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
    userModel.dispose();
  }

  @override
  void initState() {
    super.initState();
    print('#### _HomePageState - initState');
  }

  @override
  Widget build(BuildContext context) {
    print('#### _HomePageState build');

    ThemeModel themeModel = Provider.of<ThemeModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(Localization.of(context).string('app_name')),
      ),
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.all(0.0),
          children: <Widget>[
            ChangeNotifierProvider<ParseUserModel>(
              builder: (_) => userModel.user,
              child: Consumer<ParseUserModel>(
                builder: (context, user, _) {
                  return UserAccountsDrawerHeader(
                    accountName: Text(user.name),
                    accountEmail: Text(user.emailAddress),
                    currentAccountPicture: GestureDetector(
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                      ),
                    ),
                  );
                },
              ),
            ),
            ListTile(
              title: Text('Light'),
              trailing: Icon(Icons.launch),
              onTap: () {
                themeModel.typeIn.add(ThemeType.Light);
              },
            ),
            ListTile(
              title: Text('Dark'),
              trailing: Icon(Icons.launch),
              onTap: () {
                themeModel.typeIn.add(ThemeType.Dark);
              },
            ),
            Divider(),
            ListTile(
              title: Text('3'),
              trailing: Icon(Icons.settings),
              onTap: () async {},
            ),
            ListTile(
              title: Text('4'),
              trailing: Icon(Icons.settings),
              onTap: () async {},
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: () async {
                userModel.signOut();
                locator<Nav>()
                    .router
                    .navigateTo(context, 'LoginPage', clearStack: true);
              },
              child: Text('unauth'),
            ),
          ],
        ),
      ),
    );
  }
}
