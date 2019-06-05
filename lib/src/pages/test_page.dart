import 'package:flutter/material.dart';

import 'package:mall/src/core/core.dart';

class TestPage extends StatefulWidget {
  TestPage({Key key}) : super(key: key);

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Localization.of(context).string('app_name')),
      ),
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.all(0.0),
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('accountName'),
              accountEmail: Text('accountEmail'),
              currentAccountPicture: GestureDetector(
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                ),
              ),
            ),
            ListTile(
              title: Text('1'),
              trailing: Icon(Icons.launch),
              onTap: () {},
            ),
            ListTile(
              title: Text('2'),
              trailing: Icon(Icons.launch),
              onTap: () {},
            ),
            Divider(),
            ListTile(
              title: Text('3'),
              trailing: Icon(Icons.settings),
              onTap: () async {},
            ),
            ListTile(
              title: Text('4'),
              trailing: Icon(Icons.settings),
              onTap: () async {},
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: () async {},
              child: Text('btn'),
            ),
          ],
        ),
      ),
    );
  }
}
