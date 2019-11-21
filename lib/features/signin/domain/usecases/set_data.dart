import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mall/core/error/failures.dart';
import 'package:mall/core/usecase/usecase.dart';
import 'package:mall/features/signin/domain/entities/sign_in_entity.dart';
import 'package:mall/features/signin/domain/repositories/sign_in_repository.dart';

class SetData implements UseCase<SignInEntity, SetDataParams> {
  final SignInRepository repository;

  SetData(this.repository);

  @override
  Future<Either<Failure, SignInEntity>> call(SetDataParams params) async {
    return await repository.setData(
      params.username,
      params.password,
      params.obscurePassword,
    );
  }
}

class SetDataParams extends Equatable {
  final String username;
  final String password;
  final bool obscurePassword;

  SetDataParams({
    @required this.username,
    @required this.password,
    @required this.obscurePassword,
  }) : super([username, password, obscurePassword]);
}
