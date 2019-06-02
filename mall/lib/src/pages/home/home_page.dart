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
                    title: Text('light'),
                    trailing: Icon(Icons.launch),
                    onTap: () {
                      _themeBloc.dispatch(LightAppThemeEvent());
                    },
                  ),
                  ListTile(
                    title: Text('dark'),
                    trailing: Icon(Icons.launch),
                    onTap: () {
                      _themeBloc.dispatch(DarkAppThemeEvent());
                    },
                  ),
                  Divider(),
                  ListTile(
                    title: Text('print current user info'),
                    trailing: Icon(Icons.settings),
                    onTap: () async {
                      User user = await UserRepository().currentUser();
                      print('#### currentUser=$user');
                    },
                  ),
                  ListTile(
                    title: Text('sign out'),
                    trailing: Icon(Icons.settings),
                    onTap: () async {
                      _homeBloc.dispatch(SignOutEvent());
                    },
                  ),
                ],
              ),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // todo
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
