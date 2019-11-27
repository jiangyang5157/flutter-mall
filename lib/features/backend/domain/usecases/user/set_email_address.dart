import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mall/core/error/failures.dart';
import 'package:mall/core/usecase/usecase.dart';
import 'package:mall/features/backend/domain/entities/user_entity.dart';
import 'package:mall/features/backend/domain/repositories/user_repository.dart';

class SetEmailAddress implements UseCase<UserEntity, SetEmailAddressParams> {
  final UserRepository repository;

  SetEmailAddress(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(SetEmailAddressParams params) async {
    return await repository.setEmailAddress(
      params.emailAddress,
      entity: params.entity,
    );
  }
}

class SetEmailAddressParams extends Equatable {
  final String emailAddress;
  final UserEntity entity;

  SetEmailAddressParams(this.emailAddress, {this.entity})
      : super([emailAddress, entity]);
}
