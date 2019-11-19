import 'package:dartz/dartz.dart';
import 'package:mall/core/error/failures.dart';
import 'package:mall/features/signup/domain/entities/sign_up_entity.dart';

abstract class SignUpRepository {
  Future<Either<Failure, SignUpEntity>> getSignUpData();

  Future<Either<Failure, void>> setUsername(
      SignUpEntity entity, String username);

  Future<Either<Failure, void>> setPassword(
      SignUpEntity entity, String password);

  Future<Either<Failure, void>> setRepeatPassword(
      SignUpEntity entity, String repeatPassword);

  Future<Either<Failure, void>> setEmailAddress(
      SignUpEntity entity, String emailAddress);

  Future<Either<Failure, void>> setObscurePassword(
      SignUpEntity entity, bool obscurePassword);
}
