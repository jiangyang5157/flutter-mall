import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mall/core/error/failures.dart';
import 'package:mall/core/usecase/usecase.dart';
import 'package:mall/features/auth/domain/entities/auth_entity.dart';
import 'package:mall/features/auth/domain/repositories/auth_repository.dart';

class SetData implements UseCase<AuthEntity, SetDataParams> {
  final AuthRepository repository;

  SetData(this.repository);

  @override
  Future<Either<Failure, AuthEntity>> call(SetDataParams params) async {
    return await repository.setData(params.state);
  }
}

class SetDataParams extends Equatable {
  final AuthState state;

  SetDataParams({@required this.state}) : super([state]);
}
