import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mall/core/error/failures.dart';
import 'package:mall/core/usecase/usecase.dart';
import 'package:mall/features/backend/domain/entities/user_entity.dart';
import 'package:mall/features/backend/domain/repositories/user_repository.dart';

class SetType implements UseCase<UserEntity, SetTypeParams> {
  final UserRepository repository;

  SetType(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(SetTypeParams params) async {
    return await repository.setType(
      params.type,
      entity: params.entity,
    );
  }
}

class SetTypeParams extends Equatable {
  final UserType type;
  final UserEntity entity;

  SetTypeParams(this.type, {this.entity}) : super([type, entity]);
}
