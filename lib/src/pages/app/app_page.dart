import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mall/src/core/core.dart';
import 'package:mall/src/models/models.dart';
import 'package:mall/src/pages/pages.dart';
import 'package:mall/src/utils/utils.dart';
import 'package:provider/provider.dart';

class AppPage extends StatefulWidget {
  AppPage({Key key}) : super(key: key);

  @override
  _AppPageState createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  ThemeModel themeModel = ThemeModel();
  UserModel userModel = UserModel();

  @override
  void dispose() {
    themeModel.dispose();
    userModel.dispose();
    super.dispose();
    print('#### _AppPageState - dispose');
  }

  @override
  void initState() {
    super.initState();
    print('#### _AppPageState - initState');
  }

  @override
  Widget build(BuildContext context) {
    print('#### _AppPageState - build');

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeModel>(builder: (context) => themeModel),
        ChangeNotifierProvider<UserModel>(builder: (context) => userModel),
      ],
      child: Consumer2<ThemeModel, UserModel>(
        builder: (context, themeModel, userModel, _) {
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
            theme: themeModel.typeToData(context, themeModel.type),
          );
        },
      ),
    );
  }
}
