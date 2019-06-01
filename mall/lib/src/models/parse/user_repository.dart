import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:sembast/sembast.dart';

import 'package:mall/src.dart';

class UserRepository implements UserProviderContract {
  static final UserRepository _instance = UserRepository._internal();

  factory UserRepository() {
    return _instance;
  }

  UserRepository._internal() {
    _initialize();
  }

  Database _db;
  Store _store;
  static const String _db_store_User = '_db_store_User';

  Future<void> _initialize() async {
    _db = await DbProvider().db;
    _store = _db.getStore(_db_store_User);
  }

  @override
  User createUser([String username, String password, String emailAddress]) {
    return User(username, password, emailAddress);
  }

  @override
  Future<ParseResponse> save(User user) async {
    ParseResponse ret = await user.save();
    if (ret.success) {
      await _db
          .putRecord(Record(_store, parseObjectToMap(user), user.objectId));
    }
    return ret;
  }

  @override
  Future<ParseResponse> destroy(User user) async {
    ParseResponse ret = await user.destroy();
    if (ret.success) {
      await _store.delete(user.objectId);
    }
    return ret;
  }

  @override
  Future<ParseResponse> signUp(User user) {
    return user.signUp();
  }

  @override
  Future<ParseResponse> signIn(User user) {
    return user.login();
  }

  @override
  Future<ParseResponse> signOut(User user) {
    return user.logout();
  }

  @override
  Future<dynamic> currentUser() async {
    return ParseUser.currentUser();
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
