import 'package:mall/core/error/exceptions.dart';
import 'package:mall/features/signin/domain/entities/sign_in_entity.dart';

abstract class SignInLocalDataSource {
  Future<SignInEntity> getLastData();

  Future<bool> cacheData(SignInEntity entity);
}

class SignInLocalDataSourceImpl implements SignInLocalDataSource {
  SignInEntity _entity;

  @override
  Future<bool> cacheData(SignInEntity entity) async {
    _entity = entity;
    return true;
  }

  @override
  Future<SignInEntity> getLastData() async {
    if (_entity == null) {
      throw CacheException();
    }
    return _entity;
  }
}
