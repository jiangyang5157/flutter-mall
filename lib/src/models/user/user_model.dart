import 'package:flutter/material.dart';
import 'package:mall/src/core/core.dart';
import 'package:mall/src/utils/validator.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

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
    return stringToType(user.get<String>(_keyVarUserType));
  }

  set type(UserType type) {
    user.set<String>(_keyVarUserType, typeToString(type));
    notifyListeners();
  }

  bool hasUser() {
    return _user != null;
  }

  static UserType stringToType(String type) {
    return UserType.values
        .firstWhere((element) => typeToString(element) == type);
  }

  static String typeToString(UserType type) {
    return type.toString().split('.').last;
  }

  UserModel() {
    print('#### UserModel()');
  }

  @override
  void dispose() {
    super.dispose();
    print('#### UserModel - dispose');
  }

  Future<void> sync({bool fromServer = false}) async {
    ParseUser parseUser = await ParseUser.currentUser();
    if (parseUser == null) {
      user = null;
      print('#### current user not found in local');
    } else if (!fromServer) {
      user = parseUser;
      print('#### current user from local: $user');
    } else {
      ParseResponse ret = await ParseUser.getCurrentUserFromServer();
      if (ret != null && ret.success) {
        user = ret.result;
        print('#### current user from server: $user');
      } else {
        user = null;
        print('#### current user not found in server: ${ret.error.message}');
      }
    }
  }

  static UserModel create(
      {String username, String password, String emailAddress}) {
    UserModel ret = UserModel();
    ret.user = ParseUser(username, password, emailAddress);
    return ret;
  }

  Future<ParseResponse> signUp() async {
    return await user.signUp();
  }

  Future<ParseResponse> signIn() async {
    return await user.login();
  }

  Future<ParseResponse> signInAnonymous() async {
    return await user.loginAnonymous();
  }

  Future<ParseResponse> signOut() async {
    if (type == UserType.Anonymous) {
      await _destroy();
    }
    return await user.logout();
  }

  /// Save changes of current user to Server
  Future<ParseResponse> save() async {
    return await user.save();
  }

  /// Saves current user as simple key pair value to local storage
  Future<bool> pin() async {
    return await user.pin();
  }

  /// Removes a user from Parse Server locally and online
  Future<ParseResponse> _destroy() async {
    return await user.destroy();
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
      default:
        throw ("$type is not recognized as an UserType");
    }
  }
}
