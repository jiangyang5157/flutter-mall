import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:mall/src/core/core.dart';

void main() {
  runApp(AppPage());
}

class AppPage extends StatefulWidget {
  AppPage({Key key}) : super(key: key);

  @override
  _AppPageState createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        const AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: AppLocalizationsDelegate.supportedLanguageCodes
          .map<Locale>((languageCode) => Locale(languageCode)),
      onGenerateRoute: App().router.generator,
      theme: App().themeData,
    );
  }
}
