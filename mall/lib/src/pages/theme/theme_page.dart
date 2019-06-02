import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mall/src/pages/theme/theme.dart';
import 'package:mall/src/pages/app/app.dart';
import 'package:mall/src/core/core.dart';

class ThemePage extends StatefulWidget {
  ThemePage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  ThemeBloc _themeBloc;

  @override
  void initState() {
    _themeBloc = ThemeBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
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
            home: AppPage());
      },
    );
  }

  @override
  void dispose() {
    _themeBloc.dispose();
    super.dispose();
  }
}
