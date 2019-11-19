import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mall/core/error/failures.dart';
import 'package:mall/core/usecase/usecase.dart';
import 'package:mall/features/signin/domain/entities/sign_in_entity.dart';
import 'package:mall/features/signin/domain/repositories/sign_in_repository.dart';

class SetSignInPassword implements UseCase<SignInEntity, Params> {
  final SignInRepository repository;

  SetSignInPassword(this.repository);

  @override
  Future<Either<Failure, SignInEntity>> call(Params params) async {
    return await repository.setPassword(params.password);
  }
}

class Params extends Equatable {
  final String password;

  Params({
    @required this.password,
  }) : super([password]);
}
