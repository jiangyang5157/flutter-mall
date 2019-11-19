import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mall/core/error/failures.dart';
import 'package:mall/core/usecase/usecase.dart';
import 'package:mall/features/signup/domain/entities/sign_up_entity.dart';
import 'package:mall/features/signup/domain/repositories/sign_up_repository.dart';

class SetEmailAddress implements UseCase<SignUpEntity, Params> {
  final SignUpRepository repository;

  SetEmailAddress(this.repository);

  @override
  Future<Either<Failure, SignUpEntity>> call(Params params) async {
    return await repository.setUsername(params.entity, params.emailAddress);
  }
}

class Params extends Equatable {
  final SignUpEntity entity;
  final String emailAddress;

  Params({
    @required this.entity,
    @required this.emailAddress,
  }) : super([entity, emailAddress]);
}
