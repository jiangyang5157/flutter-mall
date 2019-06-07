import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

import 'package:mall/src/models/user/user.dart';

enum UserType { Master, Administrator, Normal, Anonymous }

class ParseUserModel extends ChangeNotifier implements UserContract {
  static const String _keyVarUserDisplayPicture = 'userDisplayPicture';
  static const String _keyVarUserType = 'userType';

  ParseUser _parseUser;

  void _setParseUser(ParseUser parseUser) {
    _parseUser = parseUser;
    notifyListeners();
  }

  ParseUserModel(ParseUser parseUser) {
    print('#### ParseUserModel()');
    assert(parseUser != null);
    _setParseUser(parseUser);
  }

  String get name => _parseUser.get<String>(keyVarUsername);

  set name(String name) {
    _parseUser.set<String>(keyVarUsername, name);
    notifyListeners();
  }

  String get password => _parseUser.get<String>(keyVarPassword);

  set password(String password) {
    _parseUser.set<String>(keyVarPassword, password);
    notifyListeners();
  }

  String get emailAddress => _parseUser.get<String>(keyVarEmail);

  set emailAddress(String emailAddress) {
    _parseUser.set<String>(keyVarEmail, emailAddress);
    notifyListeners();
  }

  String get displayPicture =>
      _parseUser.get<String>(_keyVarUserDisplayPicture);

  set displayPicture(String displayPicture) {
    _parseUser.set<String>(_keyVarUserDisplayPicture, displayPicture);
    notifyListeners();
  }

  UserType get type {
    return _stringToUserType(_parseUser.get<String>(_keyVarUserType));
  }

  set type(UserType type) {
    _parseUser.set<String>(_keyVarUserType, _userTypeToString(type));
    notifyListeners();
  }

  UserType _stringToUserType(String type) {
    return UserType.values
        .firstWhere((element) => _userTypeToString(element) == type);
  }

  String _userTypeToString(UserType type) {
    return type.toString().split('.').last;
  }

  @override
  Future<ParseResponse> signUp() {
    return _parseUser.signUp();
  }

  @override
  Future<ParseResponse> signIn() {
    return _parseUser.login();
  }

  @override
  Future<ParseResponse> signInAnonymous() {
    return _parseUser.loginAnonymous();
  }

  @override
  Future<ParseResponse> signOut() {
    return _parseUser.logout();
  }

  @override
  Future<ParseResponse> save() {
    return _parseUser.save();
  }

  @override
  Future<ParseResponse> destroy() {
    return _parseUser.destroy();
  }
}
