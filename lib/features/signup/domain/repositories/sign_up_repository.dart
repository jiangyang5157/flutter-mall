import 'package:dartz/dartz.dart';
import 'package:mall/core/error/failures.dart';
import 'package:mall/features/signup/domain/entities/sign_up_entity.dart';

abstract class SignUpRepository {
  Future<Either<Failure, SignUpEntity>> getData();

  Future<Either<Failure, SignUpEntity>> saveData(
      String username, String password, String emailAddress);
}
