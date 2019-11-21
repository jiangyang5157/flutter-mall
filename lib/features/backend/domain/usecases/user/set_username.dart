import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mall/core/error/failures.dart';
import 'package:mall/core/usecase/usecase.dart';
import 'package:mall/features/backend/domain/entities/user_entity.dart';
import 'package:mall/features/backend/domain/repositories/user_repository.dart';

class SetUsername implements UseCase<UserEntity, SetUsernameParams> {
  final UserRepository repository;

  SetUsername(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(SetUsernameParams params) async {
    return await repository.setUsername(
      params.entity,
      params.username,
    );
  }
}

class SetUsernameParams extends Equatable {
  final UserEntity entity;
  final String username;

  SetUsernameParams({
    @required this.entity,
    @required this.username,
  }) : super([entity, username]);
}
