import 'package:dartz/dartz.dart';
import 'package:mall/constant.dart';
import 'package:mall/core/error/failures.dart';
import 'package:mall/features/startup/domain/repositories/startup_repository.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class StartupRepositoryImpl implements StartupRepository {
  @override
  Future<Either<Failure, void>> initialization() async {
    try {
      await Parse().initialize(parseApplicationId, parseServerUrl,
          appName: parseApplicationName,
          masterKey: parseMasterKey,
          autoSendSessionId: true,
          coreStore: await CoreStoreSembastImp.getInstance(),
          debug: true);
      return Right(null);
    } catch (error) {
      return Left(ParseFailure());
    }
  }
}

class ParseFailure extends Failure {}
