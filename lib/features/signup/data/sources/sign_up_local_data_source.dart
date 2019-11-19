import 'package:mall/features/signup/domain/entities/sign_up_entity.dart';

abstract class SignUpLocalDataSource {
  Future<SignUpEntity> getLastSignUpData();

  Future<bool> cacheSignUpData(SignUpEntity entity);
}

class SignUpLocalDataSourceImpl implements SignUpLocalDataSource {
  SignUpEntity _entity;

  @override
  Future<bool> cacheSignUpData(SignUpEntity entity) async {
    _entity = entity;
    return true;
  }

  @override
  Future<SignUpEntity> getLastSignUpData() {
    throw _entity;
  }
}