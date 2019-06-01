import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mall/src/pages/app/app.dart';
import 'package:mall/src/pages/login/login.dart';
import 'package:mall/src/theme/theme.dart';
import 'package:mall/src/core/core.dart';

class AppPage extends StatefulWidget {
  AppPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  ThemeBloc _themeBloc;
  AppBloc _appBloc;

  @override
  void initState() {
    _themeBloc = ThemeBloc();
    _appBloc = AppBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProviderTree(
      blocProviders: [
        BlocProvider<ThemeBloc>(bloc: _themeBloc),
      ],
      child: BlocBuilder(
        bloc: _themeBloc,
        builder: (_, ThemeState state) {
          return MaterialApp(
              localizationsDelegates: [
                const AppLocalizationsDelegate(),
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              supportedLocales: AppLocalizationsDelegate.supportedLanguageCodes
                  .map<Locale>((languageCode) => Locale(languageCode)),
              theme: state.theme,
              home: LoginPage());
        },
      ),
    );
  }

  @override
  void dispose() {
    _themeBloc.dispose();
    _appBloc.dispose();
    super.dispose();
  }
}
