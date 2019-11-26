import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mall/features/backend/domain/entities/user_entity.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

const String _keyUserDisplayImagePath = 'userDisplayImagePath';
const String _keyVarUserType = 'userType';

class UserModel implements UserEntity {
  final ParseUser user;

  UserModel({@required this.user});

  @override
  List get props => [user.objectId];

  @override
  UserType get type => stringToType(user.get<String>(_keyVarUserType));

  set type(UserType type) =>
      user.set<String>(_keyVarUserType, typeToString(type));

  @override
  String get name => user.get<String>(keyVarUsername);

  set name(String name) => user.set<String>(keyVarUsername, name);

  @override
  String get password => user.get<String>(keyVarPassword);

  set password(String password) => user.set<String>(keyVarPassword, password);

  @override
  String get emailAddress => user.get<String>(keyVarEmail);

  set emailAddress(String emailAddress) =>
      user.set<String>(keyVarEmail, emailAddress);

  @override
  String get displayImagePath => user.get<String>(_keyUserDisplayImagePath);

  set displayImagePath(String displayImagePath) =>
      user.set<String>(_keyUserDisplayImagePath, displayImagePath);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(user: ParseUser.clone(json)..fromJson(json));
  }

  factory UserModel.fromString(String s) {
    return UserModel.fromJson(json.decode(s));
  }

  @override
  String toString() => user.toString();

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
    return await user.logout();
  }

  Future<ParseResponse> save() async {
    return await user.save();
  }

  Future<bool> pin() async {
    return await user.pin();
  }

  /// Removes a user from Parse Server locally and online
  Future<ParseResponse> destroy() async {
    return await user.destroy();
  }

  UserModel copy() {
    return UserModel(user: user.copy());
  }
}
