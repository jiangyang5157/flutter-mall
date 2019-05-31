import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'blocs.dart';

class UserBloc implements BlocBase {
  UserBloc() {
    print('#### New instance of ${this} created');
  }

  @override
  void dispose() {}
}
