import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailAddressController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    print('#### _SignUpPageState - dispose');
  }

  @override
  void initState() {
    super.initState();
    print('#### _SignUpPageState - initState');
  }

  @override
  Widget build(BuildContext context) {
    print('#### _SignUpPageState - build');

    return Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            decoration: InputDecoration(labelText: 'username'),
            obscureText: false,
            controller: _usernameController,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'password'),
            obscureText: true,
            enableInteractiveSelection: false,
            controller: _passwordController,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'email address'),
            obscureText: false,
            controller: _emailAddressController,
          ),
          RaisedButton(
            onPressed: () {},
            child: Text('sign up'),
          ),
        ],
      ),
    );
  }
}
