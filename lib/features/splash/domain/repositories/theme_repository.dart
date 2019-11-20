import 'package:dartz/dartz.dart';
import 'package:mall/core/error/failures.dart';

abstract class SplashRepository {
  Future<Either<Failure, void>> initialization();
}
