import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:mall/core/error/exceptions.dart';
import 'package:mall/core/error/failures.dart';
import 'package:mall/features/theme/data/sources/theme_local_data_source.dart';
import 'package:mall/features/theme/domain/entities/theme_entity.dart';
import 'package:mall/features/theme/domain/repositories/theme_repository.dart';

class ThemeRepositoryImpl implements ThemeRepository {
  final ThemeLocalDataSource localDataSource;

  ThemeRepositoryImpl({
    @required this.localDataSource,
  });

  @override
  Future<Either<Failure, ThemeEntity>> getData() async {
    try {
      final last = await localDataSource.getLastData();
      return Right(last);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, ThemeEntity>> setData(ThemeType type) async {
    final entity = ThemeEntity(type: type);
    try {
      await localDataSource.cacheData(entity);
      return Right(entity);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
