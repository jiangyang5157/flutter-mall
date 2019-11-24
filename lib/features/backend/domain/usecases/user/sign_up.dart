import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mall/core/error/failures.dart';
import 'package:mall/core/usecase/usecase.dart';
import 'package:mall/features/backend/domain/entities/user_entity.dart';
import 'package:mall/features/backend/domain/repositories/user_repository.dart';

class SignUp implements UseCase<UserEntity, SignUpParams> {
  final UserRepository repository;

  SignUp(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(SignUpParams params) async {
    return await repository.destroy(params.entity);
  }
}

class SignUpParams extends Equatable {
  final UserEntity entity;

  SignUpParams({
    @required this.entity,
  }) : super([entity]);
}
