import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
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
      params.entity,
      params.name,
    );
  }
}

class SetNameParams extends Equatable {
  final UserEntity entity;
  final String name;

  SetNameParams({
    @required this.entity,
    @required this.name,
  }) : super([entity, name]);
}
