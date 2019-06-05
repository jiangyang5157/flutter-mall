import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'package:mall/src/models/models.dart';
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
    return ChangeNotifierProvider<AppModel>(
      builder: (_) => AppModel(),
      child: MaterialApp(
        localizationsDelegates: [
          const AppLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: AppLocalizationsDelegate.supportedLanguageCodes
            .map<Locale>((languageCode) => Locale(languageCode)),
        initialRoute: '/',
        onGenerateRoute: App().router.generator,
        theme: App().themeData,
      ),
    );
  }
}
