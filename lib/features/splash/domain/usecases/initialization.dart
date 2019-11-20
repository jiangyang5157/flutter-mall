import 'package:dartz/dartz.dart';
import 'package:mall/core/error/failures.dart';
import 'package:mall/core/usecase/usecase.dart';
import 'package:mall/features/splash/domain/repositories/theme_repository.dart';

class Initialization implements UseCase<void, NoParams> {
  final SplashRepository repository;

  Initialization(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.initialization();
  }
}
