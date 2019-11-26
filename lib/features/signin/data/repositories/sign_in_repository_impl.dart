import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:mall/core/error/exceptions.dart';
import 'package:mall/core/error/failures.dart';
import 'package:mall/features/signin/data/sources/sign_in_local_data_source.dart';
import 'package:mall/features/signin/domain/entities/sign_in_entity.dart';
import 'package:mall/features/signin/domain/repositories/sign_in_repository.dart';

class SignInRepositoryImpl implements SignInRepository {
  final SignInLocalDataSource localDataSource;

  SignInRepositoryImpl({
    @required this.localDataSource,
  });

  @override
  Future<Either<Failure, SignInEntity>> getData() async {
    try {
      final last = await localDataSource.getLastData();
      return Right(last);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, SignInEntity>> setData(
    String username,
    String password,
    bool obscurePassword,
  ) async {
    final entity = SignInEntity(
      username: username,
      password: password,
      obscurePassword: obscurePassword,
    );
    localDataSource.setData(entity);
    return Right(entity);
  }

  @override
  Future<Either<Failure, SignInEntity>> setObscurePassword(
      bool obscurePassword) async {
    SignInEntity entity = await localDataSource.getLastData();
    final ret = SignInEntity(
      username: entity.username,
      password: entity.password,
      obscurePassword: obscurePassword,
    );
    localDataSource.setData(ret);
    return Right(ret);
  }

  @override
  Future<Either<Failure, SignInEntity>> setPassword(String password) async {
    SignInEntity entity = await localDataSource.getLastData();
    final ret = SignInEntity(
      username: entity.username,
      password: password,
      obscurePassword: entity.obscurePassword,
    );
    localDataSource.setData(ret);
    return Right(ret);
  }

  @override
  Future<Either<Failure, SignInEntity>> setUsername(String username) async {
    SignInEntity entity = await localDataSource.getLastData();
    final ret = SignInEntity(
      username: username,
      password: entity.password,
      obscurePassword: entity.obscurePassword,
    );
    localDataSource.setData(ret);
    return Right(ret);
  }
}
