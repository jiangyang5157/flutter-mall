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
    initialize();
  }

  Future initialize() async {
    ParseUser parseUser = await ParseUser.currentUser();
    if (parseUser == null) {
      _user = null;
    } else {
      _user = ParseUserModel(parseUser);
    }
  }

  @override
  Future<ParseResponse> signUp() async {
    return _user?.signUp();
  }

  @override
  Future<ParseResponse> signIn() async {
    return _user?.signIn();
  }

  @override
  Future<ParseResponse> signInAnonymous() async {
    return _user?.signInAnonymous();
  }

  @override
  Future<ParseResponse> signOut() async {
    return _user?.signOut();
  }

  @override
  Future<ParseResponse> save() async {
    ParseResponse ret = await _user?.save();
    ParseUser parseUser = ret?.result;
    if (parseUser == null) {
      user = null;
    } else {
      user = ParseUserModel(parseUser);
    }
    return ret;
  }

  @override
  Future<ParseResponse> destroy() async {
    ParseResponse ret = await _user?.destroy();
    if (ret != null && ret.success) {
      user = null;
    }
    return _user?.destroy();
  }
}
