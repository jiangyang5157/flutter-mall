import 'package:flutter/material.dart';

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
          print("snapshot=${snapshot.hasData}");
          return MaterialApp(
            theme: ThemeData(
                brightness: snapshot.data ? Brightness.dark : Brightness.light),
            home: InitializationPage(),
          );
        });
  }
}
