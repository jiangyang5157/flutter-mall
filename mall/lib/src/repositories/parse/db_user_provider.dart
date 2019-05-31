import 'dart:convert' as json;

import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:sembast/sembast.dart';
import 'package:mall/src/models/models.dart';
import 'parse.dart';

class DbUserProvider implements UserProvider {
  DbUserProvider(this._db, this._store);

  final Store _store;

  final Database _db;

  static ApiError errorNoRecordsFound =
      ApiError(1, 'No records found', false, '');
  ApiResponse responseNoRecordsFound =
      ApiResponse(false, 1, null, errorNoRecordsFound);

  @override
  Future<PUser> createUser(
      String username, String password, String emailAddress) async {
    final PUser user = PUser(username, password, emailAddress);
    final Map<String, dynamic> values = convertItemToStorageMap(user);
    final Record recordToAdd = Record(_store, values, user.objectId);
    final Record recordFromDB = await _db.putRecord(recordToAdd);
    return convertRecordToItem(record: recordFromDB);
  }

  @override
  Future<PUser> currentUser() {
    return null;
  }

  @override
  Future<ApiResponse> getCurrentUserFromServer() async {
    return null;
  }

  @override
  Future<ApiResponse> destroy(PUser user) async {
    await _store.delete(user.objectId);
    return ApiResponse(true, 200, null, null);
  }

  @override
  Future<ApiResponse> login(PUser user) async {
    return null;
  }

  @override
  Future<ApiResponse> requestPasswordReset(PUser user) async {
    return null;
  }

  @override
  Future<ApiResponse> save(PUser user) async {
    final Map<String, dynamic> values = convertItemToStorageMap(user);
    final Record recordToAdd = Record(_store, values, user.objectId);
    final Record recordFromDB = await _db.putRecord(recordToAdd);
    return ApiResponse(
        true, 200, <dynamic>[convertRecordToItem(record: recordFromDB)], null);
  }

  @override
  Future<ApiResponse> signUp(PUser user) {
    return null;
  }

  @override
  Future<ApiResponse> verificationEmailRequest(PUser user) async {
    return null;
  }

  @override
  Future<ApiResponse> allUsers() async {
    return null;
  }

  @override
  void logout(PUser user) {}

  Map<String, dynamic> convertItemToStorageMap(PUser item) {
    final Map<String, dynamic> values = Map<String, dynamic>();
    // ignore: invalid_use_of_protected_member
    values['value'] = json.jsonEncode(item.toJson(full: true));
    values[keyVarObjectId] = item.objectId;
    item.updatedAt != null
        ? values[keyVarUpdatedAt] = item.updatedAt.millisecondsSinceEpoch
        : values[keyVarCreatedAt] = DateTime.now().millisecondsSinceEpoch;
    return values;
  }

  PUser convertRecordToItem({Record record, Map<String, dynamic> values}) {
    try {
      values ??= record.value;
      final PUser ret =
          PUser.clone().fromJson(json.jsonDecode(values['value']));
      return ret;
    } catch (e) {
      return null;
    }
  }
}
