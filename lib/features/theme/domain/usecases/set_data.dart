import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mall/core/error/failures.dart';
import 'package:mall/core/usecase/usecase.dart';
import 'package:mall/features/theme/domain/entities/theme_entity.dart';
import 'package:mall/features/theme/domain/repositories/theme_repository.dart';

class SetData implements UseCase<ThemeEntity, SetDataParams> {
  final ThemeRepository repository;

  SetData(this.repository);

  @override
  Future<Either<Failure, ThemeEntity>> call(SetDataParams params) async {
    return await repository.setData(params.type);
  }
}

class SetDataParams extends Equatable {
  final ThemeType type;

  SetDataParams({@required this.type}) : super([type]);
}
