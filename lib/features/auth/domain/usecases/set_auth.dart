import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mall/core/error/failures.dart';
import 'package:mall/core/usecase/usecase.dart';
import 'package:mall/features/auth/domain/entities/auth_entity.dart';
import 'package:mall/features/auth/domain/repositories/auth_repository.dart';

class SetAuth implements UseCase<AuthEntity, SetAuthParams> {
  final AuthRepository repository;

  SetAuth(this.repository);

  @override
  Future<Either<Failure, AuthEntity>> call(SetAuthParams params) async {
    return await repository.setAuth(params.state);
  }
}

class SetAuthParams extends Equatable {
  final AuthState state;

  SetAuthParams({@required this.state}) : super([state]);
}
