import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
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
      params.entity,
      params.type,
    );
  }
}

class SetTypeParams extends Equatable {
  final UserEntity entity;
  final UserType type;

  SetTypeParams({
    @required this.entity,
    @required this.type,
  }) : super([entity, type]);
}
