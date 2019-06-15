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

    return ChangeNotifierProvider<UserModel>(
      builder: (context) => userModel,
      child: Scaffold(
        appBar: AppBar(
          title: Text(string(context, 'title_home')),
        ),
        drawer: Drawer(
          child: ChangeNotifierProvider<DrawerModel>(
              builder: (context) => DrawerModel(),
              child: Consumer2<UserModel, DrawerModel>(
                  builder: (context, userModel, drawerModel, _) {
                return ListView(
                  padding: const EdgeInsets.all(0.0),
                  children: buildDrawerList(context, userModel, drawerModel),
                );
              })),
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

  List<Widget> buildDrawerList(
      BuildContext context, UserModel userModel, DrawerModel drawerModel) {
    var ret = List<Widget>();
    ret.add(UserAccountsDrawerHeader(
      accountName: Text(userModel.user.name),
      accountEmail: Text(userModel.user.emailAddress),
      currentAccountPicture: GestureDetector(
        child: CircleAvatar(
          backgroundColor: Colors.white,
        ),
      ),
      onDetailsPressed: () {
        print('${drawerModel.state}');
        switch (drawerModel.state) {
          case DrawerState.Menu:
            drawerModel.state = DrawerState.AccountDetails;
            break;
          case DrawerState.AccountDetails:
            drawerModel.state = DrawerState.Menu;
            break;
        }
      },
    ));

    //
    ret.add(ListTile(
      title: Text('Light'),
      trailing: Icon(Icons.settings),
      onTap: () {
        Provider.of<ThemeModel>(context).typeIn.add(ThemeType.Light);
      },
    ));
    ret.add(ListTile(
      title: Text('Dark'),
      trailing: Icon(Icons.settings),
      onTap: () {
        Provider.of<ThemeModel>(context).typeIn.add(ThemeType.Dark);
      },
    ));
    ret.add(Divider());
    ret.add(ListTile(
      title: Text(string(context, 'label_sign_out')),
      trailing: Icon(Icons.settings),
      onTap: () async {
        UserModel(userModel.user).signOut();
        locator<Nav>().router.navigateTo(context, 'LoginPage',
            clearStack: true, transition: TransitionType.fadeIn);
      },
    ));

    return ret;
  }
}
