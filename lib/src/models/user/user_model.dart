import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:flutter/material.dart';

import 'package:mall/src/core/core.dart';
import 'package:mall/src/utils/validator.dart';

enum UserType {
  Master,
  Normal,
  Anonymous,
}

class UserModel extends ChangeNotifier implements Validator<Permission, bool> {
  static const String _keyVarUserDisplayPicture = 'userDisplayPicture';
  static const String _keyVarUserType = 'userType';

  ParseUser _user;

  ParseUser get user => _user;

  set user(ParseUser user) {
    _user = user;
    notifyListeners();
  }

  String get name => user.get<String>(keyVarUsername);

  set name(String name) {
    user.set<String>(keyVarUsername, name);
    notifyListeners();
  }

  String get password => user.get<String>(keyVarPassword);

  set password(String password) {
    user.set<String>(keyVarPassword, password);
    notifyListeners();
  }

  String get emailAddress => user.get<String>(keyVarEmail);

  set emailAddress(String emailAddress) {
    user.set<String>(keyVarEmail, emailAddress);
    notifyListeners();
  }

  String get displayPicture => user.get<String>(_keyVarUserDisplayPicture);

  set displayPicture(String displayPicture) {
    user.set<String>(_keyVarUserDisplayPicture, displayPicture);
    notifyListeners();
  }

  UserType get type {
    return _stringToType(user.get<String>(_keyVarUserType));
  }

  set type(UserType type) {
    user.set<String>(_keyVarUserType, _typeToString(type));
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
  void dispose() {
    super.dispose();
    print('#### UserModel - dispose');
  }

  UserModel() {
    print('#### UserModel()');
  }

  /// Reset to current user
  Future<void> init({bool fromServer = false}) async {
    ParseUser parseUser = await ParseUser.currentUser();
    if (parseUser != null) {
      if (fromServer) {
        ParseResponse ret = await ParseUser.getCurrentUserFromServer();
        if (ret != null && ret.success) {
          user = ret.result;
        } else {
          user = null;
        }
      } else {
        user = parseUser;
      }
    } else {
      user = null;
    }
  }

  static UserModel create(
      {String username, String password, String emailAddress}) {
    UserModel ret = UserModel();
    ret.user = ParseUser(username, password, emailAddress);
    return ret;
  }

  Future<ParseResponse> signUp() async {
    ParseResponse ret = await user.signUp();
    if (ret != null && ret.success) {
      user = ret.result;
      user.pin();
    }
    return ret;
  }

  Future<ParseResponse> signIn() async {
    ParseResponse ret = await user.login();
    if (ret != null && ret.success) {
      user.pin();
    }
    return ret;
  }

  Future<ParseResponse> signInAnonymous() async {
    ParseResponse ret = await user.loginAnonymous();
    if (ret != null && ret.success) {
      user.pin();
    }
    return ret;
  }

  Future<ParseResponse> signOut() async {
    ParseResponse ret = await user.logout();
    if (ret != null && ret.success) {
      user.pin();
    }
    return ret;
  }

  Future<ParseResponse> save() async {
    ParseResponse ret = await user.save();
    if (ret != null && ret.success) {
      user.pin();
    }
    return ret;
  }

  Future<ParseResponse> destroy() async {
    ParseResponse ret = await user.destroy();
    if (ret != null && ret.success) {
      user.pin();
    }
    return ret;
  }

  @override
  bool validate(Permission data) {
    switch (type) {
      case UserType.Master:
        return true;
      case UserType.Normal:
        return false;
      case UserType.Anonymous:
        return false;
    }
  }
}
