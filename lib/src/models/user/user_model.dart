import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:flutter/material.dart';

import 'package:mall/src/models/models.dart';

class UserModel extends ChangeNotifier implements UserContract {
  ParseUserModel _user;

  ParseUserModel get user => _user;

  set user(ParseUserModel user) {
    _user = user;
    notifyListeners();
  }

  UserModel() {
    print('#### UserModel()');
    _sync();
  }

  Future _sync() async {
    ParseUser parseUser = await ParseUser.currentUser();
    if (parseUser == null) {
      _user = null;
    } else {
      _user = ParseUserModel(parseUser);
    }
  }

  @override
  Future<ParseResponse> signUp() async {
    ParseResponse ret = await _user.signUp();
    if (ret.success) {
      _sync();
    }
    return ret;
  }

  @override
  Future<ParseResponse> signIn() async {
    ParseResponse ret = await _user.signIn();
    if (ret.success) {
      _sync();
    }
    return _user.signIn();
  }

  @override
  Future<ParseResponse> signInAnonymous() async {
    ParseResponse ret = await _user.signInAnonymous();
    if (ret.success) {
      _sync();
    }
    return ret;
  }

  @override
  Future<ParseResponse> signOut() async {
    ParseResponse ret = await _user.signOut();
    if (ret.success) {
      _sync();
    }
    return ret;
  }

  @override
  Future<ParseResponse> save() async {
    ParseResponse ret = await _user.save();
    if (ret.success) {
      _sync();
    }
    return ret;
  }

  @override
  Future<ParseResponse> destroy() async {
    ParseResponse ret = await _user.destroy();
    if (ret.success) {
      _sync();
    }
    return ret;
  }
}
