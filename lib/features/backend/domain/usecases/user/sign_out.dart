import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mall/core/error/failures.dart';
import 'package:mall/core/usecase/usecase.dart';
import 'package:mall/features/backend/domain/entities/user_entity.dart';
import 'package:mall/features/backend/domain/repositories/user_repository.dart';

class SignOut implements UseCase<UserEntity, SignOutParams> {
  final UserRepository repository;

  SignOut(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(SignOutParams params) async {
    return await repository.signOut(entity: params.entity);
  }
}

class SignOutParams extends Equatable {
  final UserEntity entity;

  SignOutParams({this.entity}) : super([entity]);
}
