import 'dart:convert' as json;

import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:sembast/sembast.dart';

import 'package:mall/src/parse/parse.dart';

class UserRepository implements UserProviderContract {
  static final UserRepository _instance = UserRepository._internal();

  factory UserRepository() {
    return _instance;
  }

  UserRepository._internal();

  Database _db;
  Store _store;
  static const String _db_store_User = '_db_store_User';

  /// Must initialize before use
  void initialize(Database db) async {
    _db = db;
    _store = db.getStore(_db_store_User);
  }

  @override
  User createUser({String username, String password, String emailAddress}) {
    return User(
        username: username, password: password, emailAddress: emailAddress);
  }

  @override
  Future<User> currentUser() async {
    ParseUser parseUser = await ParseUser.currentUser();
    if (parseUser == null) {
      return null;
    }
    return User()
        .clone(json.jsonDecode(json.jsonEncode(parseUser.toJson(full: true))));
  }

  @override
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
