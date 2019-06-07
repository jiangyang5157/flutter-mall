import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'package:mall/src/models/models.dart';
import 'package:mall/src/pages/pages.dart';
import 'package:mall/src/core/core.dart';

class AppPage extends StatefulWidget {
  AppPage({Key key}) : super(key: key);

  @override
  _AppPageState createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  ThemeModel themeModel;
  AppModel appModel;
  AuthModel authModel;
  UserModel userModel;

  @override
  void initState() {
    themeModel = ThemeModel();
    appModel = AppModel();
    authModel = AuthModel();
    userModel = UserModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('#### _AppPageState build');

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeModel>(builder: (_) => themeModel),
        Provider<AppModel>.value(value: appModel),
        Provider<AuthModel>.value(value: authModel),
        Provider<UserModel>.value(value: userModel),
      ],
      child: Consumer<ThemeModel>(
        builder: (context, themeModel, _) {
          return MaterialApp(
            localizationsDelegates: [
              const AppLocalizationsDelegate(),
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: AppLocalizationsDelegate.supportedLanguageCodes
                .map<Locale>((languageCode) => Locale(languageCode)),
            home: SplashPage(),
            onGenerateRoute: locator<Nav>().router.generator,
            theme: themeModel.data,
          );
        },
      ),
    );
  }
}
