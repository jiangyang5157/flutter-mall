import 'package:mall/core/error/exceptions.dart';
import 'package:mall/features/auth/domain/entities/auth_entity.dart';

abstract class AuthLocalDataSource {
  /// Throws [CacheException] if no cached data is present.
  Future<AuthEntity> getLastData();

  Future<void> cacheData(AuthEntity entity);
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  AuthEntity _entity;

  AuthLocalDataSourceImpl();

  @override
  Future<void> cacheData(AuthEntity entity) async {
    _entity = entity;
  }

  @override
  Future<AuthEntity> getLastData() async {
    if (_entity == null) {
      throw CacheException();
    }
    return _entity;
  }
}
