import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mall/core/error/failures.dart';
import 'package:mall/core/usecase/usecase.dart';
import 'package:mall/features/backend/domain/entities/user_entity.dart';
import 'package:mall/features/backend/domain/repositories/user_repository.dart';

class SetData implements UseCase<UserEntity, SetDataParams> {
  final UserRepository repository;

  SetData(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(SetDataParams params) async {
    return await repository.setData(
      params.type,
      params.username,
      params.password,
      params.emailAddress,
      params.displayImagePath,
    );
  }
}

class SetDataParams extends Equatable {
  final UserType type;
  final String username;
  final String password;
  final String emailAddress;
  final String displayImagePath;

  SetDataParams({
    @required this.type,
    @required this.username,
    @required this.password,
    @required this.emailAddress,
    @required this.displayImagePath,
  }) : super([type, username, password, emailAddress, displayImagePath]);
}
