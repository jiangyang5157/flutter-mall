import 'package:mall/features/backend/domain/entities/user_entity.dart';

abstract class UserRemoteDataSource {
  /// Throws a [ServerException] for all error codes.
  Future<UserEntity> getLastData();
}

class UserLocalDataSourceImpl implements UserRemoteDataSource {
  @override
  Future<UserEntity> getLastData() {
    // TODO: implement getLastData
    return null;
  }
}
