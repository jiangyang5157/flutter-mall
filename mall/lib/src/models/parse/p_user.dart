import 'dart:core';

import 'package:parse_server_sdk/parse_server_sdk.dart';

class PUser extends ParseUser implements ParseCloneable {
  PUser(String userName, String password, String emailAddress)
      : super(userName, password, emailAddress);

  PUser.clone() : this(null, null, null);

  @override
  PUser clone(Map<String, dynamic> map) => PUser.clone()..fromJson(map);

  static const String _db_UserName = '_db_UserName';
  static const String _db_UserDisplayPicture = '_db_UserDisplayPicture';
  static const String _db_UserType = '_db_UserType';

  String get name => get<String>(_db_UserName);

  set name(String name) => set<String>(_db_UserName, name);

  String get displayPicture => get<String>(_db_UserDisplayPicture);

  set displayPicture(String displayPicture) =>
      set<String>(_db_UserDisplayPicture, displayPicture);

  String get userType => get<String>(_db_UserType);

  set userType(String userType) => set<String>(_db_UserType, userType);
}
