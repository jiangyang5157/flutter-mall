import 'package:mall/features/signin/domain/entities/sign_in_entity.dart';

abstract class SignInLocalDataSource {
  Future<SignInEntity> getLastSignInData();

  Future<bool> cacheSignInData(SignInEntity entity);
}

class SignInLocalDataSourceImpl implements SignInLocalDataSource {
  SignInEntity _entity;

  @override
  Future<bool> cacheSignInData(SignInEntity entity) async {
    _entity = entity;
    return true;
  }

  @override
  Future<SignInEntity> getLastSignInData() {
    throw _entity;
  }
}
