import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mall/src/pages/theme_app/theme_app.dart';
import 'package:mall/src/core/core.dart';

class ThemeAppPage extends StatefulWidget {
  ThemeAppPage({Key key}) : super(key: key);

  @override
  _ThemeAppPageState createState() => _ThemeAppPageState();
}

class _ThemeAppPageState extends State<ThemeAppPage> {
  ThemeAppBloc _themeBloc;

  @override
  void dispose() {
    _themeBloc.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _themeBloc = ThemeAppBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ThemeAppBloc>(
      bloc: _themeBloc,
      child: BlocBuilder(
        bloc: _themeBloc,
        builder: (_, ThemeAppState state) {
          return MaterialApp(
            localizationsDelegates: [
              const AppLocalizationsDelegate(),
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: AppLocalizationsDelegate.supportedLanguageCodes
                .map<Locale>((languageCode) => Locale(languageCode)),
            onGenerateRoute: Navigation().router.generator,
            theme: state.theme,
          );
        },
      ),
    );
  }
}
