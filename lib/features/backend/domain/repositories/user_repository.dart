import 'package:dartz/dartz.dart';
import 'package:mall/core/error/failures.dart';
import 'package:mall/features/backend/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<Either<Failure, UserEntity>> getLastUser({bool fromMemory = true});

  Future<Either<Failure, UserEntity>> setType(UserType type,
      {UserEntity entity});

  Future<Either<Failure, UserEntity>> setName(String name, {UserEntity entity});

  Future<Either<Failure, UserEntity>> setPassword(String password,
      {UserEntity entity});

  Future<Either<Failure, UserEntity>> setEmailAddress(String emailAddress,
      {UserEntity entity});

  Future<Either<Failure, UserEntity>> setDisplayImagePath(
      String displayImagePath,
      {UserEntity entity});

  Future<Either<Failure, UserEntity>> destroy({UserEntity entity});

  Future<Either<Failure, UserEntity>> save({UserEntity entity});

  Future<Either<Failure, UserEntity>> signIn({UserEntity entity});

  Future<Either<Failure, UserEntity>> signInAnonymous({UserEntity entity});

  Future<Either<Failure, UserEntity>> signOut({UserEntity entity});

  Future<Either<Failure, UserEntity>> signUp({UserEntity entity});
}
