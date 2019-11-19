import 'package:dartz/dartz.dart';
import 'package:mall/core/error/failures.dart';
import 'package:mall/features/signin/domain/entities/sign_in_entity.dart';

abstract class SignInRepository {
  Future<Either<Failure, SignInEntity>> getData();

  Future<Either<Failure, SignInEntity>> setData(
      String username, String password, bool obscurePassword);

  Future<Either<Failure, void>> setUsername(
      SignInEntity entity, String username);

  Future<Either<Failure, void>> setPassword(
      SignInEntity entity, String password);

  Future<Either<Failure, void>> setObscurePassword(
      SignInEntity entity, bool obscurePassword);
}
