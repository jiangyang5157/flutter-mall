import 'package:dartz/dartz.dart';
import 'package:mall/core/error/failures.dart';
import 'package:mall/features/signup/domain/entities/sign_up_entity.dart';

abstract class SignUpRepository {
  Future<Either<Failure, SignUpEntity>> getData();

  Future<Either<Failure, SignUpEntity>> setData(
      String username,
      String password,
      String repeatPassword,
      String emailAddress,
      bool obscurePassword);

  Future<Either<Failure, SignUpEntity>> setUsername(
      SignUpEntity entity, String username);

  Future<Either<Failure, SignUpEntity>> setPassword(
      SignUpEntity entity, String password);

  Future<Either<Failure, SignUpEntity>> setRepeatPassword(
      SignUpEntity entity, String repeatPassword);

  Future<Either<Failure, SignUpEntity>> setEmailAddress(
      SignUpEntity entity, String emailAddress);

  Future<Either<Failure, SignUpEntity>> setObscurePassword(
      SignUpEntity entity, bool obscurePassword);
}
