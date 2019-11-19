import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mall/core/error/failures.dart';
import 'package:mall/core/usecase/usecase.dart';
import 'package:mall/features/signup/domain/entities/sign_up_entity.dart';
import 'package:mall/features/signup/domain/repositories/sign_up_repository.dart';

class SetRepeatPassword
    implements UseCase<SignUpEntity, SetRepeatPasswordParams> {
  final SignUpRepository repository;

  SetRepeatPassword(this.repository);

  @override
  Future<Either<Failure, SignUpEntity>> call(
      SetRepeatPasswordParams params) async {
    return await repository.setRepeatPassword(
        params.entity, params.repeatPassword);
  }
}

class SetRepeatPasswordParams extends Equatable {
  final SignUpEntity entity;
  final String repeatPassword;

  SetRepeatPasswordParams({
    @required this.entity,
    @required this.repeatPassword,
  }) : super([entity, repeatPassword]);
}
