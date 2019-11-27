import 'package:mall/core/error/exceptions.dart';
import 'package:mall/features/backend/data/models/user_model.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

abstract class UserLocalDataSource {
  /// Throws [CacheException] if no cached data is present.
  Future<UserModel> getLastUser({bool fromMemory = true});

  /// Throws [CacheException]
  Future<UserModel> setUser(UserModel model);
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  UserModel _model;

  @override
  Future<UserModel> setUser(UserModel model) async {
    if (await model.user.pin()) {
      _model = model;
    } else {
      throw CacheException();
    }
    return _model;
  }

  @override
  Future<UserModel> getLastUser({bool fromMemory = true}) async {
    if (_model == null || !fromMemory) {
      final parseUser = await ParseUser.currentUser();
      if (parseUser == null) {
        throw CacheException();
      } else {
        _model = UserModel(user: parseUser);
      }
    }
    return _model;
  }
}
