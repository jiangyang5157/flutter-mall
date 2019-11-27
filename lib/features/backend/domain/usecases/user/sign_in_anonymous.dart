import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mall/core/error/failures.dart';
import 'package:mall/core/usecase/usecase.dart';
import 'package:mall/features/backend/domain/entities/user_entity.dart';
import 'package:mall/features/backend/domain/repositories/user_repository.dart';

class SignInAnonymous implements UseCase<UserEntity, SignInAnonymousParams> {
  final UserRepository repository;

  SignInAnonymous(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(SignInAnonymousParams params) async {
    return await repository.signInAnonymous(entity: params.entity);
  }
}

class SignInAnonymousParams extends Equatable {
  final UserEntity entity;

  SignInAnonymousParams({this.entity}) : super([entity]);
}
