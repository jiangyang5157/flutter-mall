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

  void initialize(Database db) async {
    _db = db;
    _store = db.getStore(_db_store_User);
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
  Future<ParseResponse> signUp(User user) async {
    ParseResponse ret = await user.signUp();
    if (ret.success) {
      await _db
          .putRecord(Record(_store, parseObjectToMap(user), user.objectId));
    }
    return ret;
  }

  @override
  Future<ParseResponse> signIn(User user) async {
    ParseResponse ret = await user.login();
    if (ret.success) {
      await _db
          .putRecord(Record(_store, parseObjectToMap(user), user.objectId));
    }
    return ret;
  }

  @override
  Future<ParseResponse> signOut(User user) {
    return user.logout();
  }

  @override
  Future<User> currentUser() async {
    ParseUser parseUser = await ParseUser.currentUser();
    if (parseUser == null) {
      return null;
    }
    return fromParseUser(parseUser);
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

  @override
  User fromParseUser(ParseUser parseUser) {
    return mapToParseObject<User>(User(), parseObjectToMap(parseUser));
  }
}
