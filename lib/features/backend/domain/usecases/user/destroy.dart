import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mall/core/error/failures.dart';
import 'package:mall/core/usecase/usecase.dart';
import 'package:mall/features/backend/domain/entities/user_entity.dart';
import 'package:mall/features/backend/domain/repositories/user_repository.dart';

class Destroy implements UseCase<UserEntity, DestroyParams> {
  final UserRepository repository;

  Destroy(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(DestroyParams params) async {
    return await repository.destroy(params.entity);
  }
}

class DestroyParams extends Equatable {
  final UserEntity entity;

  DestroyParams({
    @required this.entity,
  }) : super([entity]);
}
