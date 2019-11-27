import 'package:mall/core/error/exceptions.dart';
import 'package:mall/features/auth/domain/entities/auth_entity.dart';

abstract class AuthLocalDataSource {
  /// Throws [CacheException] if no cached data is present.
  Future<AuthEntity> getLastAuth({bool fromMemory = true});

  Future<AuthEntity> setAuth(AuthEntity entity);
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  AuthEntity _entity;

  @override
  Future<AuthEntity> setAuth(AuthEntity entity) async {
    _entity = entity;
    return _entity;
  }

  @override
  Future<AuthEntity> getLastAuth({bool fromMemory = true}) async {
    if (_entity == null || !fromMemory) {
      throw CacheException();
    }
    return _entity;
  }
}
