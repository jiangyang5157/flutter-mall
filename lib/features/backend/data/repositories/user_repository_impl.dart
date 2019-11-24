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
  Future<Either<Failure, UserEntity>> getData() async {
    try {
      final local = await localDataSource.getLastData();
      return Right(local);
    } on CacheException {
      if (await networkInfo.isConnected) {
        try {
          final remote = await remoteDataSource.getLastData();
          localDataSource.cacheData(remote);
          return Right(remote);
        } on ServerException {
          return Left(ServerFailure());
        }
      } else {
        return Left(ServerFailure());
      }
    }
  }

  @override
  Future<Either<Failure, UserEntity>> setDisplayImagePath(
    UserEntity entity,
    String displayImagePath,
  ) async {
    UserModel model = entity as UserModel;
    model.displayImagePath = displayImagePath;
    localDataSource.cacheData(model);
    return Right(model);
  }

  @override
  Future<Either<Failure, UserEntity>> setEmailAddress(
    UserEntity entity,
    String emailAddress,
  ) async {
    UserModel model = entity as UserModel;
    model.emailAddress = emailAddress;
    localDataSource.cacheData(model);
    return Right(model);
  }

  @override
  Future<Either<Failure, UserEntity>> setPassword(
      UserEntity entity, String password) async {
    UserModel model = entity as UserModel;
    model.password = password;
    localDataSource.cacheData(model);
    return Right(model);
  }

  @override
  Future<Either<Failure, UserEntity>> setType(
    UserEntity entity,
    UserType type,
  ) async {
    UserModel model = entity as UserModel;
    model.type = type;
    localDataSource.cacheData(model);
    return Right(model);
  }

  @override
  Future<Either<Failure, UserEntity>> setName(
    UserEntity entity,
    String name,
  ) async {
    UserModel model = entity as UserModel;
    model.name = name;
    localDataSource.cacheData(model);
    return Right(model);
  }
}
