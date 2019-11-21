import 'package:flutter/material.dart';

class UserViewModel extends ChangeNotifier {
  UserViewModel() {
    print('#### UserViewModel - constructor');
  }

  @override
  void dispose() {
    super.dispose();
    print('#### UserViewModel - dispose');
  }
}
