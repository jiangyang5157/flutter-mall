import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:mall/core/error/exceptions.dart';
import 'package:mall/core/error/failures.dart';
import 'package:mall/features/auth/data/sources/auth_local_data_source.dart';
import 'package:mall/features/auth/domain/entities/auth_entity.dart';
import 'package:mall/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    @required this.localDataSource,
  });

  @override
  Future<Either<Failure, AuthEntity>> getLastAuth(
      {bool fromMemory = true}) async {
    try {
      return Right(await localDataSource.getLastAuth(fromMemory: fromMemory));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, AuthEntity>> setAuth(AuthState state) async {
    final entity = AuthEntity(state: state);
    localDataSource.setAuth(entity);
    return Right(entity);
  }
}
