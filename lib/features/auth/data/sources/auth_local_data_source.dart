import 'package:mall/core/error/exceptions.dart';
import 'package:mall/features/auth/domain/entities/auth_entity.dart';

abstract class AuthLocalDataSource {
  /// Throws [CacheException] if no cached data is present.
  Future<AuthEntity> getLastAuth();

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
  Future<AuthEntity> getLastAuth() async {
    if (_entity == null) {
      throw CacheException();
    }
    return _entity;
  }
}
