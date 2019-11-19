import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mall/core/error/failures.dart';
import 'package:mall/core/usecase/usecase.dart';
import 'package:mall/features/signin/domain/entities/sign_in_entity.dart';
import 'package:mall/features/signin/domain/repositories/sign_in_repository.dart';

class SetSignInUsername implements UseCase<SignInEntity, Params> {
  final SignInRepository repository;

  SetSignInUsername(this.repository);

  @override
  Future<Either<Failure, SignInEntity>> call(Params params) async {
    return await repository.setUsername(params.username);
  }
}

class Params extends Equatable {
  final String username;

  Params({
    @required this.username,
  }) : super([username]);
}
