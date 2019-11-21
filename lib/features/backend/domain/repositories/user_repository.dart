import 'package:dartz/dartz.dart';
import 'package:mall/core/error/failures.dart';
import 'package:mall/features/backend/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<Either<Failure, UserEntity>> getData();

  Future<Either<Failure, UserEntity>> setData(
    UserType type,
    String username,
    String password,
    String emailAddress,
    String displayImagePath,
  );

  Future<Either<Failure, UserEntity>> setUserType(
    UserEntity entity,
    UserType type,
  );

  Future<Either<Failure, UserEntity>> setUsername(
    UserEntity entity,
    String username,
  );

  Future<Either<Failure, UserEntity>> setPassword(
    UserEntity entity,
    String password,
  );

  Future<Either<Failure, UserEntity>> setEmailAddress(
    UserEntity entity,
    String emailAddress,
  );

  Future<Either<Failure, UserEntity>> setDisplayImagePath(
    UserEntity entity,
    String displayImagePath,
  );
}
