import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import 'package:mall/src/models/models.dart';

class UserModel extends ChangeNotifier implements UserContract {
  BehaviorSubject<ParseUserModel> _userController =
      BehaviorSubject<ParseUserModel>();

  Stream<ParseUserModel> get userOut => _userController.stream;

  Sink<ParseUserModel> get userIn => _userController.sink;

  ParseUserModel get user => _userController.value;

  set user(ParseUserModel parseUserModel) {
    userIn.add(parseUserModel);
  }

  @override
  void dispose() {
    _userController.close();
    super.dispose();
    print('#### UserModel - dispose');
  }

  UserModel([ParseUserModel parseUserModel]) {
    print('#### UserModel()');
    userOut.listen(_setUser);
    if (parseUserModel == null) {
      _sync();
    } else {
      user = parseUserModel;
    }
  }

  static UserModel createUser(
      {String username, String password, String emailAddress}) {
    return UserModel(
        ParseUserModel(ParseUser(username, password, emailAddress)));
  }

  void _setUser(ParseUserModel parseUserModel) {
    notifyListeners();
  }

  Future _sync() async {
    ParseUser parseUser = await ParseUser.currentUser();
    if (parseUser != null) {
      user = ParseUserModel(parseUser);
    } else {
      user = null;
    }
  }

  @override
  Future<ParseResponse> signUp() async {
    ParseResponse ret = await user.signUp();
    if (ret.success) {
      _sync();
    }
    return ret;
  }

  @override
  Future<ParseResponse> signIn() async {
    ParseResponse ret = await user.signIn();
    if (ret.success) {
      _sync();
    }
    return ret;
  }

  @override
  Future<ParseResponse> signInAnonymous() async {
    ParseResponse ret = await user.signInAnonymous();
    if (ret.success) {
      _sync();
    }
    return ret;
  }

  @override
  Future<ParseResponse> signOut() async {
    ParseResponse ret = await user.signOut();
    if (ret.success) {
      _sync();
    }
    return ret;
  }

  @override
  Future<ParseResponse> save() async {
    ParseResponse ret = await user.save();
    if (ret.success) {
      _sync();
    }
    return ret;
  }

  @override
  Future<ParseResponse> destroy() async {
    ParseResponse ret = await user.destroy();
    if (ret.success) {
      _sync();
    }
    return ret;
  }
}
