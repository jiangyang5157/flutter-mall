import 'dart:core';

import 'package:parse_server_sdk/parse_server_sdk.dart';

class PUser extends ParseUser implements ParseCloneable {
  PUser(String username, String password, String emailAddress)
      : super(username, password, emailAddress);

  PUser.clone() : this(null, null, null);

  @override
  PUser clone(Map<String, dynamic> map) => PUser.clone()..fromJson(map);

  static const String keyUserName = 'keyUserName';
  static const String keyUserDisplayPicture = 'keyUserDisplayPicture';
  static const String keyUserType = 'keyUserType';

  String get name => get<String>(keyUserName);

  set name(String name) => set<String>(keyUserName, name);

  String get displayPicture => get<String>(keyUserDisplayPicture);

  set displayPicture(String displayPicture) =>
      set<String>(keyUserDisplayPicture, displayPicture);

  String get userType => get<String>(keyUserType);

  set userType(String userType) => set<String>(keyUserType, userType);
}
