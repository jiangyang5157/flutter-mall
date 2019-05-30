import 'package:flutter/material.dart';

import 'package:mall/src/blocs/blocs.dart';
import 'package:mall/src/ui/pages/pages.dart';

class ApplicationPage extends StatefulWidget {
  ApplicationPage({Key key}) : super(key: key);

  @override
  _ApplicationPageState createState() => _ApplicationPageState();
}

class _ApplicationPageState extends State<ApplicationPage> {
  @override
  Widget build(BuildContext context) {
    final ApplicationBloc appBloc = BlocProvider.of<ApplicationBloc>(context);

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
