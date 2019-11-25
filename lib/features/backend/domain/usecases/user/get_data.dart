import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mall/core/error/failures.dart';
import 'package:mall/core/usecase/usecase.dart';
import 'package:mall/features/backend/domain/entities/user_entity.dart';
import 'package:mall/features/backend/domain/repositories/user_repository.dart';

class GetData implements UseCase<UserEntity, GetDataParams> {
  final UserRepository repository;

  GetData(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(GetDataParams params) async {
    return await repository.getData(params.forceRemote);
  }
}

class GetDataParams extends Equatable {
  final bool forceRemote;

  GetDataParams({
    @required this.forceRemote,
  }) : super([forceRemote]);
}
