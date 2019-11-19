import 'package:mall/core/error/exceptions.dart';
import 'package:mall/features/signup/domain/entities/sign_up_entity.dart';

abstract class SignUpLocalDataSource {
  /// Throws [CacheException] if no cached data is present.
  Future<SignUpEntity> getLastData();

  Future<void> cacheData(SignUpEntity entity);
}

class SignUpLocalDataSourceImpl implements SignUpLocalDataSource {
  SignUpEntity _entity;

  @override
  Future<void> cacheData(SignUpEntity entity) async {
    _entity = entity;
  }

  @override
  Future<SignUpEntity> getLastData() async {
    if (_entity == null) {
      throw CacheException();
    }
    return _entity;
  }
}
