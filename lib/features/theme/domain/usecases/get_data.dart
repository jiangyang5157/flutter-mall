import 'package:dartz/dartz.dart';
import 'package:mall/core/error/failures.dart';
import 'package:mall/core/usecase/usecase.dart';
import 'package:mall/features/theme/domain/entities/theme_entity.dart';
import 'package:mall/features/theme/domain/repositories/theme_repository.dart';

class GetData implements UseCase<ThemeEntity, NoParams> {
  final ThemeRepository repository;

  GetData(this.repository);

  @override
  Future<Either<Failure, ThemeEntity>> call(NoParams params) async {
    return await repository.getData();
  }
}
