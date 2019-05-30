import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:mall/src/app/app.dart';
import 'package:mall/src/blocs/blocs.dart';
import 'package:mall/src/ui/pages/pages.dart';

class AppPage extends StatefulWidget {
  AppPage({Key key}) : super(key: key);

  @override
  _AppPageState createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  @override
  Widget build(BuildContext context) {
    final AppBloc appBloc = BlocProvider.of<AppBloc>(context);

    return StreamBuilder<bool>(
        stream: appBloc.outDarkTheme,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          return MaterialApp(
            localizationsDelegates: [
              const AppLocalizationsDelegate(),
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: AppLocalizationsDelegate.supportedLanguageCodes
                .map<Locale>((languageCode) => Locale(languageCode)),
            theme: ThemeData(
                brightness: snapshot.data ? Brightness.dark : Brightness.light),
            initialRoute: "/",
            routes: <String, WidgetBuilder>{
              "/": (BuildContext context) => SplashPage(),
              "/AuthenticationPage": (BuildContext context) =>
                  AuthenticationPage(),
            },
          );
        });
  }
}
