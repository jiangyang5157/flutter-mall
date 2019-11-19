import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mall/core/error/failures.dart';
import 'package:mall/core/usecase/usecase.dart';
import 'package:mall/features/signup/domain/entities/sign_up_entity.dart';
import 'package:mall/features/signup/domain/repositories/sign_up_repository.dart';

class SetSignUpData implements UseCase<SignUpEntity, Params> {
  final SignUpRepository repository;

  SetSignUpData(this.repository);

  @override
  Future<Either<Failure, SignUpEntity>> call(Params params) async {
    return await repository.saveData(
        params.username, params.password, params.emailAddress);
  }
}

class Params extends Equatable {
  final String username;
  final String password;
  final String emailAddress;

  Params({
    @required this.username,
    @required this.password,
    @required this.emailAddress,
  }) : super([username, password, emailAddress]);
}
