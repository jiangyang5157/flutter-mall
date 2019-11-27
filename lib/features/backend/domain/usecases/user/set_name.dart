import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mall/core/error/failures.dart';
import 'package:mall/core/usecase/usecase.dart';
import 'package:mall/features/backend/domain/entities/user_entity.dart';
import 'package:mall/features/backend/domain/repositories/user_repository.dart';

class SetName implements UseCase<UserEntity, SetNameParams> {
  final UserRepository repository;

  SetName(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(SetNameParams params) async {
    return await repository.setName(
      params.name,
      entity: params.entity,
    );
  }
}

class SetNameParams extends Equatable {
  final String name;
  final UserEntity entity;

  SetNameParams(this.name, {this.entity}) : super([name, entity]);
}
