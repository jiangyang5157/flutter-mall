import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

import 'package:mall/src/models/user/user.dart';

enum UserType { Master, Administrator, Normal, Anonymous }

class ParseUserModel extends ChangeNotifier implements UserContract {
  static const String _keyVarUserDisplayPicture = 'userDisplayPicture';
  static const String _keyVarUserType = 'userType';

  final ParseUser _parseUser;

  @override
  void dispose() {
    super.dispose();
    print('#### ParseUserModel - dispose');
  }

  ParseUserModel(this._parseUser) {
    print('#### ParseUserModel()');
    assert(_parseUser != null);
    notifyListeners();
  }

  String get name => _parseUser.get<String>(keyVarUsername);

  set name(String username) {
    _parseUser.set<String>(keyVarUsername, username);
    notifyListeners();
  }

  String get password => _parseUser.get<String>(keyVarPassword);

  set password(String userPassword) {
    _parseUser.set<String>(keyVarPassword, userPassword);
    notifyListeners();
  }

  String get emailAddress => _parseUser.get<String>(keyVarEmail);

  set emailAddress(String userEmailAddress) {
    _parseUser.set<String>(keyVarEmail, userEmailAddress);
    notifyListeners();
  }

  String get displayPicture =>
      _parseUser.get<String>(_keyVarUserDisplayPicture);

  set displayPicture(String userDisplayPicture) {
    _parseUser.set<String>(_keyVarUserDisplayPicture, userDisplayPicture);
    notifyListeners();
  }

  UserType get type {
    return _stringToType(_parseUser.get<String>(_keyVarUserType));
  }

  set type(UserType userType) {
    _parseUser.set<String>(_keyVarUserType, _typeToString(userType));
    notifyListeners();
  }

  UserType _stringToType(String userType) {
    return UserType.values
        .firstWhere((element) => _typeToString(element) == userType);
  }

  String _typeToString(UserType userType) {
    return userType.toString().split('.').last;
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
