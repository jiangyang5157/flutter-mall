import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mall/src/pages/app/app.dart';
import 'package:mall/src/pages/home/home.dart';
import 'package:mall/src/core/core.dart';

class AppPage extends StatefulWidget {
  AppPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  AppBloc _appBloc;
  HomeBloc _homeBloc;

  @override
  void initState() {
    _appBloc = AppBloc();
    _homeBloc = HomeBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocProviders: [
        BlocProvider<AppBloc>(bloc: _appBloc),
      ],
      child: BlocBuilder(
        bloc: _appBloc,
        builder: (_, AppState state) {
          return MaterialApp(
              localizationsDelegates: [
                const AppLocalizationsDelegate(),
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              supportedLocales: AppLocalizationsDelegate.supportedLanguageCodes
                  .map<Locale>((languageCode) => Locale(languageCode)),
//              theme: state.theme,
              home: HomePage());
        },
      ),
    );
  }

  @override
  void dispose() {
    _appBloc.dispose();
    _homeBloc.dispose();
    super.dispose();
  }
}
