import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mall/core/error/failures.dart';
import 'package:mall/core/usecase/usecase.dart';
import 'package:mall/features/backend/domain/entities/user_entity.dart';
import 'package:mall/features/backend/domain/repositories/user_repository.dart';

class SetDisplayImagePath
    implements UseCase<UserEntity, SetDisplayImagePathParams> {
  final UserRepository repository;

  SetDisplayImagePath(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(
      SetDisplayImagePathParams params) async {
    return await repository.setDisplayImagePath(
      params.entity,
      params.displayImagePath,
    );
  }
}

class SetDisplayImagePathParams extends Equatable {
  final UserEntity entity;
  final String displayImagePath;

  SetDisplayImagePathParams({
    @required this.entity,
    @required this.displayImagePath,
  }) : super([entity, displayImagePath]);
}
