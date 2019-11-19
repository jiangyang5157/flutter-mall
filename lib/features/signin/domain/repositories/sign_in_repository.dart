import 'package:dartz/dartz.dart';
import 'package:mall/core/error/failures.dart';
import 'package:mall/features/signin/domain/entities/sign_in_entity.dart';

abstract class SignInRepository {
  Future<Either<Failure, SignInEntity>> getData();

  Future<Either<Failure, SignInEntity>> setUsername(String username);

  Future<Either<Failure, SignInEntity>> setPassword(String password);

  Future<Either<Failure, SignInEntity>> setObscurePassword(
      bool obscurePassword);
}
