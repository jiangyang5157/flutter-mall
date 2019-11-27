import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mall/core/error/failures.dart';
import 'package:mall/core/usecase/usecase.dart';
import 'package:mall/features/backend/domain/entities/user_entity.dart';
import 'package:mall/features/backend/domain/repositories/user_repository.dart';

class SignIn implements UseCase<UserEntity, SignInParams> {
  final UserRepository repository;

  SignIn(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(SignInParams params) async {
    return await repository.signIn(entity: params.entity);
  }
}

class SignInParams extends Equatable {
  final UserEntity entity;

  SignInParams({this.entity}) : super([entity]);
}
