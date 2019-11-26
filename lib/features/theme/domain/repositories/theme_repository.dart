import 'package:dartz/dartz.dart';
import 'package:mall/core/error/failures.dart';
import 'package:mall/features/theme/domain/entities/theme_entity.dart';

abstract class ThemeRepository {
  Future<Either<Failure, ThemeEntity>> getLastTheme();

  Future<Either<Failure, ThemeEntity>> setTheme(ThemeType type);
}
