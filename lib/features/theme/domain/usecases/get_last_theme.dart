import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mall/core/error/failures.dart';
import 'package:mall/core/usecase/usecase.dart';
import 'package:mall/features/theme/domain/entities/theme_entity.dart';
import 'package:mall/features/theme/domain/repositories/theme_repository.dart';

class GetLastTheme implements UseCase<ThemeEntity, GetLastThemeParams> {
  final ThemeRepository repository;

  GetLastTheme(this.repository);

  @override
  Future<Either<Failure, ThemeEntity>> call(GetLastThemeParams params) async {
    return await repository.getLastTheme(fromMemory: params.fromMemory);
  }
}

class GetLastThemeParams extends Equatable {
  final bool fromMemory;

  GetLastThemeParams({this.fromMemory = true}) : super([fromMemory]);
}
