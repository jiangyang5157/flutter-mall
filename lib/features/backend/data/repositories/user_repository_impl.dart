import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:mall/core/error/failures.dart';
import 'package:mall/core/network/network_info.dart';
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
  Future<Either<Failure, UserEntity>> getData() {
    // TODO: implement getData
    return null;
  }

  @override
  Future<Either<Failure, UserEntity>> setData(
    UserType type,
    String username,
    String password,
    String emailAddress,
    String displayImagePath,
  ) {
    // TODO: implement setData
    return null;
  }

  @override
  Future<Either<Failure, UserEntity>> setDisplayImagePath(
    UserEntity entity,
    String displayImagePath,
  ) {
    // TODO: implement setDisplayImagePath
    return null;
  }

  @override
  Future<Either<Failure, UserEntity>> setEmailAddress(
    UserEntity entity,
    String emailAddress,
  ) {
    // TODO: implement setEmailAddress
    return null;
  }

  @override
  Future<Either<Failure, UserEntity>> setPassword(
      UserEntity entity, String password) {
    // TODO: implement setPassword
    return null;
  }

  @override
  Future<Either<Failure, UserEntity>> setUserType(
    UserEntity entity,
    UserType type,
  ) {
    // TODO: implement setUserType
    return null;
  }

  @override
  Future<Either<Failure, UserEntity>> setUsername(
    UserEntity entity,
    String username,
  ) {
    // TODO: implement setUsername
    return null;
  }
}
