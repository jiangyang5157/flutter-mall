import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class ParseUserModel extends ChangeNotifier {
  static const String _keyVarUserDisplayPicture = 'userDisplayPicture';
  static const String _keyVarUserType = 'userType';

  ParseUser _parseUser;

  ParseUserModel(ParseUser parseUser) {
    _parseUser = parseUser;
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

  String get type => _parseUser.get<String>(_keyVarUserType);

  set type(String type) {
    _parseUser.set<String>(_keyVarUserType, type);
    notifyListeners();
  }
}
