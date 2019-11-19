import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:mall/core/error/exceptions.dart';
import 'package:mall/core/error/failures.dart';
import 'package:mall/core/network/network_info.dart';
import 'package:mall/features/theme/data/models/theme_model.dart';
import 'package:mall/features/theme/data/sources/theme_local_data_source.dart';
import 'package:mall/features/theme/data/sources/theme_remote_data_source.dart';
import 'package:mall/features/theme/domain/entities/theme_entity.dart';
import 'package:mall/features/theme/domain/repositories/theme_repository.dart';

class ThemeRepositoryImpl implements ThemeRepository {
  final ThemeLocalDataSource localDataSource;
  final ThemeRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ThemeRepositoryImpl({
    @required this.localDataSource,
    @required this.remoteDataSource,
    @required this.networkInfo,
  });

  @override
  Future<bool> shouldFetch() {
    return Future.value(false);
  }

  @override
  Future<Either<Failure, ThemeModel>> getTheme() async {
    if (await shouldFetch() && await networkInfo.isConnected) {
      try {
        return Right(await remoteDataSource.fetchTheme().then((result) {
          localDataSource.cacheTheme(result);
          return result;
        }));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        return Right(await localDataSource.getLastTheme());
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, ThemeModel>> saveTheme(ThemeType type) async {
    final ret = ThemeModel(type: type);
    localDataSource.cacheTheme(ret);
    return Right(ret);
  }
}
