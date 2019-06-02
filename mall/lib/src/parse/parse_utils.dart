import 'dart:convert' as json;

import 'package:parse_server_sdk/parse_server_sdk.dart';

const String parseApplicationName = 'MyApp';
const String parseApplicationId = 'myAppId';
const String parseMasterKey = 'myMasterKey';
//const String parseServerUrl = 'http://localhost:1337/parse';
const String parseServerUrl = 'http://10.0.2.2:1337/parse'; // Android emulator

Map<String, dynamic> parseObjectToMap(ParseObject object) {
  if (object == null) {
    return null;
  }
  try {
    final Map<String, dynamic> ret = Map<String, dynamic>();
    // ignore: invalid_use_of_protected_member
    ret['ParseObject'] = json.jsonEncode(object.toJson(full: true));
    ret[keyVarObjectId] = object.objectId;
    object.updatedAt != null
        ? ret[keyVarUpdatedAt] = object.updatedAt.millisecondsSinceEpoch
        : ret[keyVarCreatedAt] = DateTime.now().millisecondsSinceEpoch;
    return ret;
  } catch (e) {
    return null;
  }
}

T mapToParseObject<T extends ParseObject>(T object, Map<String, dynamic> data) {
  if (object == null) {
    return null;
  }
  if (data == null) {
    return object;
  }
  try {
    final T ret = object.clone(json.jsonDecode(data['ParseObject']));
    return ret;
  } catch (e) {
    return null;
  }
}
