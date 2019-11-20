import 'package:dartz/dartz.dart';
import 'package:mall/core/error/failures.dart';

abstract class StartupRepository {
  Future<Either<Failure, void>> initialization();
}
