import 'dart:convert' as json;

import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:sembast/sembast.dart';
import 'package:flutter/material.dart';

import 'package:mall/src/parse/parse.dart';
import 'package:mall/src/models/models.dart';

class UserModel extends ChangeNotifier {

  ParseUserModel _user;

  ParseUserModel get user => _user;

  UserModel() {
    initialize();
  }

  Future initialize() async {
    ParseUser parseUser = await ParseUser.currentUser();
    _user = ParseUserModel(parseUser);
    notifyListeners();
  }

  Future<ParseResponse> save(User user) async {
    ParseResponse ret = await user.save();
    if (ret.success) {
      await _db
          .putRecord(Record(_store, user.toJson(full: true), user.objectId));
    }
    return ret;
  }

  @override
  Future forget(User user) async {
    await user.unpin(key: keyParseStoreUser);
    await _store.delete(user.objectId);
  }

  @override
  Future<ParseResponse> destroy(User user) async {
    ParseResponse ret = await user.destroy();
    if (ret.success) {
      user.unpin(key: keyParseStoreUser);
      await _store.delete(user.objectId);
    }
    return ret;
  }

  @override
  Future<ParseResponse> signUp(User user) async {
    ParseResponse ret = await user.signUp();
    if (ret.success) {
      await _db
          .putRecord(Record(_store, user.toJson(full: true), user.objectId));
    }
    return ret;
  }

  @override
  Future<ParseResponse> signIn(User user) async {
    ParseResponse ret = await user.login();
    if (ret.success) {
      await _db
          .putRecord(Record(_store, user.toJson(full: true), user.objectId));
    }
    return ret;
  }

  @override
  Future<ParseResponse> signOut(User user) {
    return user.logout();
  }

  @override
  Future<ParseResponse> getCurrentUserFromServer() {
    return ParseUser.getCurrentUserFromServer();
  }

  @override
  Future<ParseResponse> requestPasswordReset(User user) {
    return user.requestPasswordReset();
  }

  @override
  Future<ParseResponse> verificationEmailRequest(User user) {
    return user.verificationEmailRequest();
  }
}
