import 'package:flutter/material.dart';
import 'package:mall/src/core/core.dart';
import 'package:mall/src/utils/utils.dart';

String string(BuildContext context, String id) =>
    Localization.of(context).string(id) ?? null;

void runOnWidgetDidBuild(Function func) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    func();
  });
}

void showSimpleSnackBar(BuildContext context, String content) {
  Scaffold.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
      duration: Duration(milliseconds: snackBarDurationInMilliseconds),
    ),
  );
}

void showSimpleAlertDialog(BuildContext context, String title,
    List<Widget> body, List<Widget> actions) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: ListBody(
            children: body,
          ),
        ),
        actions: actions,
      );
    },
  );
}

void todo(BuildContext context) {
  showSimpleAlertDialog(
    context,
    'TODO',
    <Widget>[
      Text('Handle this case.'),
    ],
    <Widget>[
      FlatButton(
        child: Text('Gotcha'),
        onPressed: () {
          locator<Nav>().router.pop(context);
        },
      ),
    ],
  );
}
