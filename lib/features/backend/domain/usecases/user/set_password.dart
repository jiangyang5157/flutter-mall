import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
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
      params.entity,
      params.password,
    );
  }
}

class SetPasswordParams extends Equatable {
  final UserEntity entity;
  final String password;

  SetPasswordParams({
    @required this.entity,
    @required this.password,
  }) : super([entity, password]);
}
