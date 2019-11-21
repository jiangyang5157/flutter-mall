import 'package:mall/core/error/exceptions.dart';
import 'package:mall/features/backend/domain/entities/user_entity.dart';

abstract class UserLocalDataSource {
  /// Throws [CacheException] if no cached data is present.
  Future<UserEntity> getLastData();

  Future<void> cacheData(UserEntity entity);
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  @override
  Future<void> cacheData(UserEntity entity) {
    // TODO: implement cacheData
    return null;
  }

  @override
  Future<UserEntity> getLastData() {
    // TODO: implement getLastData
    return null;
  }
}
