import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mall/core/error/failures.dart';
import 'package:mall/core/usecase/usecase.dart';
import 'package:mall/features/signup/domain/entities/sign_up_entity.dart';
import 'package:mall/features/signup/domain/repositories/sign_up_repository.dart';

class SetData implements UseCase<SignUpEntity, SetDataParams> {
  final SignUpRepository repository;

  SetData(this.repository);

  @override
  Future<Either<Failure, SignUpEntity>> call(SetDataParams params) async {
    return await repository.setData(
      params.username,
      params.password,
      params.repeatPassword,
      params.emailAddress,
      params.obscurePassword,
    );
  }
}

class SetDataParams extends Equatable {
  final String username;
  final String password;
  final String repeatPassword;
  final String emailAddress;
  final bool obscurePassword;

  SetDataParams({
    @required this.username,
    @required this.password,
    @required this.repeatPassword,
    @required this.emailAddress,
    @required this.obscurePassword,
  }) : super([
          username,
          password,
          repeatPassword,
          emailAddress,
          obscurePassword
        ]);
}
