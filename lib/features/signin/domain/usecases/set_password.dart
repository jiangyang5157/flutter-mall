import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mall/core/error/failures.dart';
import 'package:mall/core/usecase/usecase.dart';
import 'package:mall/features/signin/domain/entities/sign_in_entity.dart';
import 'package:mall/features/signin/domain/repositories/sign_in_repository.dart';

class SetPassword implements UseCase<SignInEntity, SetPasswordParams> {
  final SignInRepository repository;

  SetPassword(this.repository);

  @override
  Future<Either<Failure, SignInEntity>> call(SetPasswordParams params) async {
    return await repository.setPassword(params.entity, params.password);
  }
}

class SetPasswordParams extends Equatable {
  final SignInEntity entity;
  final String password;

  SetPasswordParams({
    @required this.entity,
    @required this.password,
  }) : super([entity, password]);
}
