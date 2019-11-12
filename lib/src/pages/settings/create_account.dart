import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mall/src/utils/utils.dart';

class CreateAccountPage extends StatefulWidget {
  CreateAccountPage({Key key}) : super(key: key);

  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  @override
  void dispose() {
    super.dispose();
    print('#### _CreateAccountPageState - dispose');
  }

  @override
  void initState() {
    super.initState();
    print('#### _CreateAccountPageState - initState');
  }

  @override
  Widget build(BuildContext context) {
    print('#### _CreateAccountPageState - build');

    return Scaffold(
      appBar: AppBar(
          title: Text(string(context, 'title_create_account')),
          actions: <Widget>[
            // action button
            FlatButton(
              textColor: Colors.white,
              child: Text(string(context, 'label_create')),
//              onPressed: null,
              onPressed: () {
                todo(context);
              },
            ),
          ]),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    // A fixed-height child.
                    color: const Color(0xff808000), // Yellow
                    height: 111.0,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
