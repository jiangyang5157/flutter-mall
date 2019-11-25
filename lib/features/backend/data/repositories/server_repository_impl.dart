import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:mall/core/constant.dart';
import 'package:mall/core/error/failures.dart';
import 'package:mall/core/network/network_info.dart';
import 'package:mall/features/backend/domain/repositories/server_repository.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class ServerRepositoryImpl implements ServerRepository {
  final NetworkInfo networkInfo;

  ServerRepositoryImpl({
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, void>> initialization() async {
    if (await networkInfo.isConnected) {
      try {
        await Parse().initialize(
          parseApplicationId,
          parseServerUrl,
          appName: parseApplicationName,
          masterKey: parseMasterKey,
          autoSendSessionId: true,
          // Required for authentication and ACL
          coreStore: await CoreStoreSembastImp.getInstance(),
          // Local data storage method. Will use SharedPreferences instead of Sembast as an internal DB
          debug: true, // When enabled, prints logs to console
        );
        return Right(null);
      } catch (error) {
        return Left(ServerFailure(error.toString()));
      }
    } else {
      return Left(ServerFailure("Network is not connected."));
    }
  }
}
