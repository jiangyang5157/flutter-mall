import 'package:dartz/dartz.dart';
import 'package:mall/core/error/failures.dart';
import 'package:mall/features/backend/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<Either<Failure, UserEntity>> getCurrentUser();

  Future<Either<Failure, UserEntity>> setType(
    UserEntity entity,
    UserType type,
  );

  Future<Either<Failure, UserEntity>> setName(
    UserEntity entity,
    String name,
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

  Future<Either<Failure, UserEntity>> destroy(UserEntity entity);

  Future<Either<Failure, UserEntity>> save(UserEntity entity);

  Future<Either<Failure, UserEntity>> signIn(UserEntity entity);

  Future<Either<Failure, UserEntity>> signInAnonymous(UserEntity entity);

  Future<Either<Failure, UserEntity>> signOut(UserEntity entity);

  Future<Either<Failure, UserEntity>> signUp(UserEntity entity);
}
