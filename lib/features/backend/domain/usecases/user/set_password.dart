import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mall/core/error/failures.dart';
import 'package:mall/core/usecase/usecase.dart';
import 'package:mall/features/backend/domain/entities/user_entity.dart';
import 'package:mall/features/backend/domain/repositories/user_repository.dart';

class SetPassword implements UseCase<UserEntity, SetPasswordParams> {
  final UserRepository repository;

  SetPassword(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(SetPasswordParams params) async {
    return await repository.setPassword(
      params.password,
      entity: params.entity,
    );
  }
}

class SetPasswordParams extends Equatable {
  final String password;
  final UserEntity entity;

  SetPasswordParams(this.password, {this.entity}) : super([password, entity]);
}
