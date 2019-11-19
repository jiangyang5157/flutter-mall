import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mall/core/error/failures.dart';
import 'package:mall/core/usecase/usecase.dart';
import 'package:mall/features/signup/domain/entities/sign_up_entity.dart';
import 'package:mall/features/signup/domain/repositories/sign_up_repository.dart';

class SetUsername implements UseCase<SignUpEntity, SetUsernameParams> {
  final SignUpRepository repository;

  SetUsername(this.repository);

  @override
  Future<Either<Failure, SignUpEntity>> call(SetUsernameParams params) async {
    return await repository.setUsername(params.entity, params.username);
  }
}

class SetUsernameParams extends Equatable {
  final SignUpEntity entity;
  final String username;

  SetUsernameParams({
    @required this.entity,
    @required this.username,
  }) : super([entity, username]);
}
