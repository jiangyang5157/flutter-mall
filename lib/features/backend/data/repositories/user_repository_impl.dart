import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:mall/core/error/exceptions.dart';
import 'package:mall/core/error/failures.dart';
import 'package:mall/core/network/network_info.dart';
import 'package:mall/features/backend/data/models/user_model.dart';
import 'package:mall/features/backend/data/sources/user_local_data_source.dart';
import 'package:mall/features/backend/data/sources/user_remote_data_source.dart';
import 'package:mall/features/backend/domain/entities/user_entity.dart';
import 'package:mall/features/backend/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserLocalDataSource localDataSource;
  final UserRemoteDataSource remoteDataSource;

  final NetworkInfo networkInfo;

  UserRepositoryImpl({
    @required this.localDataSource,
    @required this.remoteDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, UserEntity>> getLastUser(
      {bool fromMemory = true}) async {
    try {
      final local = await localDataSource.getLastUser(fromMemory: fromMemory);
      return Right(local);
    } on CacheException {
      // ignore
    }

    if (await networkInfo.isConnected) {
      try {
        final remote =
            await remoteDataSource.getLastUser(fromMemory: fromMemory);
        return Right(remote);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return Left(ServerFailure("Network is not connected."));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> destroy({UserEntity entity}) async {
    UserModel model;
    if (entity == null) {
      model = await localDataSource.getLastUser();
    } else {
      model = entity as UserModel;
    }

    try {
      model = await remoteDataSource.destroy(model);
      if (entity == null) {
        model = await localDataSource.setUser(model);
      }
      return Right(model);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> save({UserEntity entity}) async {
    UserModel model;
    if (entity == null) {
      model = await localDataSource.getLastUser();
    } else {
      model = entity as UserModel;
    }

    try {
      model = await remoteDataSource.save(model);
      if (entity == null) {
        model = await localDataSource.setUser(model);
      }
      return Right(model);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> setDisplayImagePath(
      String displayImagePath,
      {UserEntity entity}) async {
    UserModel model;
    if (entity == null) {
      model = await localDataSource.getLastUser();
    } else {
      model = entity as UserModel;
    }

    if (model.displayImagePath == displayImagePath) {
      return Right(model);
    }

    model.displayImagePath = displayImagePath;
    try {
      model = await remoteDataSource.save(model);
      if (entity == null) {
        model = await localDataSource.setUser(model);
      }
      return Right(model);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> setEmailAddress(String emailAddress,
      {UserEntity entity}) async {
    UserModel model;
    if (entity == null) {
      model = await localDataSource.getLastUser();
    } else {
      model = entity as UserModel;
    }

    if (model.emailAddress == emailAddress) {
      return Right(model);
    }

    model.emailAddress = emailAddress;
    try {
      model = await remoteDataSource.save(model);
      if (entity == null) {
        model = await localDataSource.setUser(model);
      }
      return Right(model);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> setName(String name,
      {UserEntity entity}) async {
    UserModel model;
    if (entity == null) {
      model = await localDataSource.getLastUser();
    } else {
      model = entity as UserModel;
    }

    if (model.name == name) {
      return Right(model);
    }

    model.name = name;
    try {
      model = await remoteDataSource.save(model);
      if (entity == null) {
        model = await localDataSource.setUser(model);
      }
      return Right(model);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> setPassword(String password,
      {UserEntity entity}) async {
    UserModel model;
    if (entity == null) {
      model = await localDataSource.getLastUser();
    } else {
      model = entity as UserModel;
    }

    if (model.password == password) {
      return Right(model);
    }

    model.password = password;
    try {
      model = await remoteDataSource.save(model);
      if (entity == null) {
        model = await localDataSource.setUser(model);
      }
      return Right(model);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> setType(UserType type,
      {UserEntity entity}) async {
    UserModel model;
    if (entity == null) {
      model = await localDataSource.getLastUser();
    } else {
      model = entity as UserModel;
    }

    if (model.type == type) {
      return Right(model);
    }

    model.type = type;
    try {
      model = await remoteDataSource.save(model);
      if (entity == null) {
        model = await localDataSource.setUser(model);
      }
      return Right(model);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signIn({UserEntity entity}) async {
    UserModel model;
    if (entity == null) {
      model = await localDataSource.getLastUser();
    } else {
      model = entity as UserModel;
    }

    try {
      model = await remoteDataSource.signIn(model);
      if (entity == null) {
        model = await localDataSource.setUser(model);
      }
      return Right(model);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInAnonymous(
      {UserEntity entity}) async {
    UserModel model;
    if (entity == null) {
      model = await localDataSource.getLastUser();
    } else {
      model = entity as UserModel;
    }

    try {
      model = await remoteDataSource.signInAnonymous(model);
      if (entity == null) {
        model = await localDataSource.setUser(model);
      }
      return Right(model);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signOut({UserEntity entity}) async {
    UserModel model;
    if (entity == null) {
      model = await localDataSource.getLastUser();
    } else {
      model = entity as UserModel;
    }

    try {
      model = await remoteDataSource.signOut(model);
      if (entity == null) {
        model = await localDataSource.setUser(model);
      }
      return Right(model);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signUp({UserEntity entity}) async {
    UserModel model;
    if (entity == null) {
      model = await localDataSource.getLastUser();
    } else {
      model = entity as UserModel;
    }

    try {
      model = await remoteDataSource.signUp(model);
      if (entity == null) {
        model = await localDataSource.setUser(model);
      }
      return Right(model);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
