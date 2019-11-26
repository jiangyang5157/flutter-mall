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
import 'package:parse_server_sdk/parse_server_sdk.dart';

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
  Future<Either<Failure, UserEntity>> getCurrentUser() async {
    try {
      final local = await localDataSource.getLastData();
      return Right(local);
    } on CacheException {
      // ignore
    }

    if (await networkInfo.isConnected) {
      try {
        final remote = await remoteDataSource.getLastData();
        return Right(remote);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return Left(ServerFailure("Network is not connected."));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> setDisplayImagePath(
    UserEntity entity,
    String displayImagePath,
  ) async {
    UserModel model = entity as UserModel;
    model.displayImagePath = displayImagePath;
    ParseResponse result = await model.save();
    if (result.success) {
      return Right(model);
    } else {
      return Left(ServerFailure(result.error.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> setEmailAddress(
    UserEntity entity,
    String emailAddress,
  ) async {
    UserModel model = entity as UserModel;
    model.emailAddress = emailAddress;
    ParseResponse result = await model.save();
    if (result.success) {
      return Right(model);
    } else {
      return Left(ServerFailure(result.error.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> setPassword(
      UserEntity entity, String password) async {
    UserModel model = entity as UserModel;
    model.password = password;
    ParseResponse result = await model.save();
    if (result.success) {
      return Right(model);
    } else {
      return Left(ServerFailure(result.error.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> setType(
    UserEntity entity,
    UserType type,
  ) async {
    UserModel model = entity as UserModel;
    model.type = type;
    ParseResponse result = await model.save();
    if (result.success) {
      return Right(model);
    } else {
      return Left(ServerFailure(result.error.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> setName(
    UserEntity entity,
    String name,
  ) async {
    UserModel model = entity as UserModel;
    model.name = name;
    ParseResponse result = await model.save();
    if (result.success) {
      return Right(model);
    } else {
      return Left(ServerFailure(result.error.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> destroy(UserEntity entity) async {
    UserModel model = entity as UserModel;
    ParseResponse result = await model.destroy();
    if (result.success) {
      return Right(model);
    } else {
      return Left(ServerFailure(result.error.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> save(UserEntity entity) async {
    UserModel model = entity as UserModel;
    ParseResponse result = await model.save();
    if (result.success) {
      return Right(model);
    } else {
      return Left(ServerFailure(result.error.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signIn(UserEntity entity) async {
    UserModel model = entity as UserModel;
    ParseResponse result = await model.signIn();
    if (result.success) {
      return Right(model);
    } else {
      return Left(ServerFailure(result.error.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInAnonymous(UserEntity entity) async {
    UserModel model = entity as UserModel;
    ParseResponse result = await model.signInAnonymous();
    if (result.success) {
      return Right(model);
    } else {
      return Left(ServerFailure(result.error.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signOut(UserEntity entity) async {
    UserModel model = entity as UserModel;
    ParseResponse result = await model.signOut();
    if (result.success) {
      return Right(model);
    } else {
      return Left(ServerFailure(result.error.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signUp(UserEntity entity) async {
    UserModel model = entity as UserModel;
    ParseResponse result = await model.signUp();
    if (result.success) {
      return Right(model);
    } else {
      return Left(ServerFailure(result.error.message));
    }
  }
}
