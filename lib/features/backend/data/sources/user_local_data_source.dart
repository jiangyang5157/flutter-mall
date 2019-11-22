import 'package:mall/core/error/exceptions.dart';
import 'package:mall/features/backend/data/models/user_model.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

abstract class UserLocalDataSource {
  /// Throws [CacheException] if no cached data is present.
  Future<UserModel> getLastData();

  Future<void> cacheData(UserModel model);
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  @override
  Future<void> cacheData(UserModel model) {
    return model.user.save();
  }

  @override
  Future<UserModel> getLastData() async {
    ParseUser parseUser = await ParseUser.currentUser();
    if (parseUser == null) {
      throw CacheException();
    }
    return UserModel(user: parseUser);
  }
}
