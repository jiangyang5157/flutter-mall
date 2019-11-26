import 'package:mall/core/error/exceptions.dart';
import 'package:mall/features/signin/domain/entities/sign_in_entity.dart';

abstract class SignInLocalDataSource {
  /// Throws [CacheException] if no cached data is present.
  Future<SignInEntity> getLastData();

  Future<SignInEntity> setData(SignInEntity entity);
}

class SignInLocalDataSourceImpl implements SignInLocalDataSource {
  SignInEntity _entity;

  @override
  Future<SignInEntity> setData(SignInEntity entity) async {
    _entity = entity;
    return _entity;
  }

  @override
  Future<SignInEntity> getLastData() async {
    if (_entity == null) {
      throw CacheException();
    }
    return _entity;
  }
}
