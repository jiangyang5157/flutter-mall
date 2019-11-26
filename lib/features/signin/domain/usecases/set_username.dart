import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mall/core/error/failures.dart';
import 'package:mall/core/usecase/usecase.dart';
import 'package:mall/features/signin/domain/entities/sign_in_entity.dart';
import 'package:mall/features/signin/domain/repositories/sign_in_repository.dart';

class SetUsername implements UseCase<SignInEntity, SetUsernameParams> {
  final SignInRepository repository;

  SetUsername(this.repository);

  @override
  Future<Either<Failure, SignInEntity>> call(SetUsernameParams params) async {
    return await repository.setUsername(params.username);
  }
}

class SetUsernameParams extends Equatable {
  final String username;

  SetUsernameParams({@required this.username}) : super([username]);
}
