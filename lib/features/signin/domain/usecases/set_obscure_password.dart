import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mall/core/error/failures.dart';
import 'package:mall/core/usecase/usecase.dart';
import 'package:mall/features/signin/domain/entities/sign_in_entity.dart';
import 'package:mall/features/signin/domain/repositories/sign_in_repository.dart';

class SetObscurePassword
    implements UseCase<SignInEntity, SetObscurePasswordParams> {
  final SignInRepository repository;

  SetObscurePassword(this.repository);

  @override
  Future<Either<Failure, SignInEntity>> call(
      SetObscurePasswordParams params) async {
    return await repository.setObscurePassword(
        params.entity, params.obscurePassword);
  }
}

class SetObscurePasswordParams extends Equatable {
  final SignInEntity entity;
  final bool obscurePassword;

  SetObscurePasswordParams({
    @required this.entity,
    @required this.obscurePassword,
  }) : super([entity, obscurePassword]);
}
