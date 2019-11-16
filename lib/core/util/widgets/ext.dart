import 'package:flutter/material.dart';

import 'package:mall/constant.dart';
import 'package:mall/core/util/nav.dart';
import 'package:mall/injection.dart';

void runOnWidgetDidBuild(Function func) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    func();
  });
}

void showSimpleSnackBar(ScaffoldState state, String content,
    {int milliseconds = snackBarDurationInMilliseconds}) {
  state.showSnackBar(
    SnackBar(
      content: Text(content),
      duration: Duration(milliseconds: milliseconds),
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
