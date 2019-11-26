import 'package:dartz/dartz.dart';
import 'package:mall/core/error/failures.dart';

abstract class ServerRepository {
  Future<Either<Failure, String>> initialization();
}
