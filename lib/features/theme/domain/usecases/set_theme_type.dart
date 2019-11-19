import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mall/core/error/failures.dart';
import 'package:mall/core/usecase/usecase.dart';
import 'package:mall/features/theme/domain/entities/theme_entity.dart';
import 'package:mall/features/theme/domain/repositories/theme_repository.dart';

class SetThemeType implements UseCase<ThemeEntity, Params> {
  final ThemeRepository repository;

  SetThemeType(this.repository);

  @override
  Future<Either<Failure, ThemeEntity>> call(Params params) async {
    return await repository.setThemeType(params.type);
  }
}

class Params extends Equatable {
  final ThemeType type;

  Params({@required this.type}) : super([type]);
}
