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
  Future<Either<Failure, SignUpEntity>> getData() async {
    try {
      final last = await localDataSource.getLastData();
      return Right(last);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, SignUpEntity>> saveData(
      String username, String password, String emailAddress) async {
    final ret = SignUpEntity(
        username: username, password: password, emailAddress: emailAddress);
    localDataSource.cacheData(ret);
    return Right(ret);
  }
}
