import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mall/src/pages/home/home.dart';
import 'package:mall/src/pages/theme_app/theme_app.dart';
import 'package:mall/src/pages/app/app.dart';
import 'package:mall/src/parse/parse.dart';
import 'package:mall/src/core/core.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ThemeAppBloc _themeBloc;
  AppBloc _appBloc;
  HomeBloc _homeBloc;

  @override
  void initState() {
    _themeBloc = BlocProvider.of<ThemeAppBloc>(context);
    _appBloc = BlocProvider.of<AppBloc>(context);
    _homeBloc = HomeBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProviderTree(
      blocProviders: [
        BlocProvider<HomeBloc>(bloc: _homeBloc),
      ],
      child: BlocBuilder(
        bloc: _homeBloc,
        builder: (_, HomeState state) {
          if (state is SignOutFinishState) {
            _appBloc.dispatch(AppSignedOutEvent());
          }

          return Scaffold(
            appBar: AppBar(
              title: Text(AppLocalization.of(context).string('title_home')),
            ),
            drawer: Drawer(
              child: ListView(
                padding: const EdgeInsets.all(0.0),
                children: <Widget>[
                  UserAccountsDrawerHeader(
                    accountName: Text('accountName'),
                    accountEmail: Text('accountEmail'),
                    currentAccountPicture: GestureDetector(
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text('ListTile 1'),
                    trailing: Icon(Icons.launch),
                    onTap: () {},
                  ),
                  Divider(),
                  ListTile(
                    title: Text('ListTile 2'),
                    trailing: Icon(Icons.settings),
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
                      _homeBloc.dispatch(SignOutEvent());
                    },
                    child: Text('sign out'),
                  ),
                  RaisedButton(
                    onPressed: () {
                      _themeBloc.dispatch(LightAppThemeEvent());
                    },
                    child: Text('light'),
                  ),
                  RaisedButton(
                    onPressed: () {
                      _themeBloc.dispatch(DarkAppThemeEvent());
                    },
                    child: Text('dark'),
                  ),
                  RaisedButton(
                    onPressed: () async {
                      User user = await UserRepository().currentUser();
                      print('#### currentUser=$user');
                    },
                    child: Text('print current user info'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _homeBloc.dispose();
    super.dispose();
  }
}
