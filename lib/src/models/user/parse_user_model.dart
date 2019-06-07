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
    return _stringToType(_parseUser.get<String>(_keyVarUserType));
  }

  set type(UserType type) {
    _parseUser.set<String>(_keyVarUserType, _typeToString(type));
    notifyListeners();
  }

  UserType _stringToType(String type) {
    return UserType.values
        .firstWhere((element) => _typeToString(element) == type);
  }

  String _typeToString(UserType type) {
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
