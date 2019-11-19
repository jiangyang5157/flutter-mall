import 'package:dartz/dartz.dart';
import 'package:mall/core/error/failures.dart';
import 'package:mall/features/signin/domain/entities/sign_in_entity.dart';

abstract class SignInRepository {
  Future<Either<Failure, SignInEntity>> getData();

  Future<Either<Failure, SignInEntity>> saveData(
      String username, String password);
}
