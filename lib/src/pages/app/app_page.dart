import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mall/src/pages/app/app.dart';
import 'package:mall/src/pages/home/home.dart';
import 'package:mall/src/pages/splash/splash.dart';
import 'package:mall/src/pages/login/login.dart';

class AppPage extends StatefulWidget {
  AppPage({Key key}) : super(key: key);

  @override
  _AppPageState createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  AppBloc _appBloc;

  @override
  void dispose() {
    _appBloc.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _appBloc = AppBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppBloc>(
      bloc: _appBloc,
      child: BlocBuilder(
        bloc: _appBloc,
        builder: (_, AppState state) {
          if (state is AppUninitializedState) {
            return SplashPage();
          }
          if (state is AppInitializedState) {
            return LoginPage();
          }
          if (state is AppUnauthenticatedState) {
            return LoginPage();
          }
          if (state is AppAuthenticatedState) {
            return HomePage();
          }
        },
      ),
    );
  }
}
