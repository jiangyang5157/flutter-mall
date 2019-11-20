import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mall/core/util/localization/string_localization.dart';
import 'package:mall/core/util/nav.dart';
import 'package:mall/features/theme/presentation/theme_view_model.dart';
import 'package:mall/injection.dart';
import 'package:mall/models/user/user_model.dart';
import 'package:mall/features/splash/presentation/pages/splash_page.dart';
import 'package:provider/provider.dart';

class AppPage extends StatefulWidget {
  AppPage({Key key}) : super(key: key);

  @override
  _AppPageState createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  ThemeViewModel themeViewModel = locator<ThemeViewModel>();
  UserModel userModel = UserModel();

  @override
  void dispose() {
    themeViewModel.dispose();
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
        ChangeNotifierProvider<ThemeViewModel>(
            builder: (context) => themeViewModel),
        ChangeNotifierProvider<UserModel>(builder: (context) => userModel),
      ],
      child: Consumer2<ThemeViewModel, UserModel>(
        builder: (context, themeViewModel, userModel, _) {
          return MaterialApp(
            localizationsDelegates: [
              const StringDelegate(),
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: StringDelegate.supportedLanguageCodes
                .map<Locale>((languageCode) => Locale(languageCode)),
            home: SplashPage(),
            onGenerateRoute: locator<Nav>().router.generator,
            theme: themeViewModel.getCurrentData().toThemeData(context),
          );
        },
      ),
    );
  }
}
