import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:mall/core/error/exceptions.dart';
import 'package:mall/core/error/failures.dart';
import 'package:mall/features/signup/data/sources/sign_up_local_data_source.dart';
import 'package:mall/features/signup/domain/entities/sign_up_entity.dart';
import 'package:mall/features/signup/domain/repositories/sign_up_repository.dart';

class SignUpRepositoryImpl implements SignUpRepository {
  final SignUpLocalDataSource localDataSource;

  SignUpRepositoryImpl({
    @required this.localDataSource,
  });

  @override
  Future<Either<Failure, SignUpEntity>> getSignUpData() async {
    try {
      final last = await localDataSource.getLastSignUpData();
      return Right(last);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> setEmailAddress(
      SignUpEntity entity, String emailAddress) async {
    final ret = SignUpEntity(
        username: entity.username,
        password: entity.password,
        repeatPassword: entity.repeatPassword,
        emailAddress: emailAddress,
        obscurePassword: entity.obscurePassword);
    localDataSource.cacheSignUpData(ret);
    return Right(ret);
  }

  @override
  Future<Either<Failure, void>> setObscurePassword(
      SignUpEntity entity, bool obscurePassword) async {
    final ret = SignUpEntity(
        username: entity.username,
        password: entity.password,
        repeatPassword: entity.repeatPassword,
        emailAddress: entity.emailAddress,
        obscurePassword: obscurePassword);
    localDataSource.cacheSignUpData(ret);
    return Right(ret);
  }

  @override
  Future<Either<Failure, void>> setPassword(
      SignUpEntity entity, String password) async {
    final ret = SignUpEntity(
        username: entity.username,
        password: password,
        repeatPassword: entity.repeatPassword,
        emailAddress: entity.emailAddress,
        obscurePassword: entity.obscurePassword);
    localDataSource.cacheSignUpData(ret);
    return Right(ret);
  }

  @override
  Future<Either<Failure, void>> setRepeatPassword(
      SignUpEntity entity, String repeatPassword) async {
    final ret = SignUpEntity(
        username: entity.username,
        password: entity.password,
        repeatPassword: repeatPassword,
        emailAddress: entity.emailAddress,
        obscurePassword: entity.obscurePassword);
    localDataSource.cacheSignUpData(ret);
    return Right(ret);
  }

  @override
  Future<Either<Failure, void>> setUsername(
      SignUpEntity entity, String username) async {
    final ret = SignUpEntity(
        username: username,
        password: entity.password,
        repeatPassword: entity.repeatPassword,
        emailAddress: entity.emailAddress,
        obscurePassword: entity.obscurePassword);
    localDataSource.cacheSignUpData(ret);
    return Right(ret);
  }
}