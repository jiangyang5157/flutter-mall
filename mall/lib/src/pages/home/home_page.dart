import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mall/src/pages/home/home.dart';
import 'package:mall/src/pages/theme_app/theme_app.dart';
import 'package:mall/src/pages/app/app.dart';
import 'package:mall/src/parse/parse.dart';

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
    return BlocProvider<HomeBloc>(
      bloc: _homeBloc,
      child: BlocBuilder(
        bloc: _homeBloc,
        builder: (_, HomeState state) {
          if (state is HomeLogoutCompletedState) {
            _appBloc.dispatch(AppSignedOutEvent());
          }

          return Scaffold(
            appBar: AppBar(
              title: Text('Home'),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    onPressed: () async {
                      _homeBloc.dispatch(HomeSignOutEvent());
                    },
                    child: Text('sign out'),
                  ),
                  RaisedButton(
                    onPressed: () {
                      _themeBloc.dispatch(ThemeAppLightEvent());
                    },
                    child: Text('light'),
                  ),
                  RaisedButton(
                    onPressed: () {
                      _themeBloc.dispatch(ThemeAppDarkEvent());
                    },
                    child: Text('dark'),
                  ),
                  RaisedButton(
                    onPressed: () async {
                      User user = await UserRepository().currentUser();
                      print("#### currentUser=$user");
                    },
                    child: Text('check current user'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
