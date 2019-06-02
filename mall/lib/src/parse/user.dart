import 'dart:core';

import 'package:parse_server_sdk/parse_server_sdk.dart';

class User extends ParseUser {
  User([String username, String password, String emailAddress])
      : super(username, password, emailAddress);

  @override
  User clone(Map<String, dynamic> map) => fromJson(map);

  static const String keyVarUserDisplayPicture = 'userDisplayPicture';
  static const String keyVarUserType = 'userType';

  String get displayPicture => get<String>(keyVarUserDisplayPicture);

  set displayPicture(String displayPicture) =>
      set<String>(keyVarUserDisplayPicture, displayPicture);

  String get userType => get<String>(keyVarUserType);

  set userType(String userType) => set<String>(keyVarUserType, userType);
}
