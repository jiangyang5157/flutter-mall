import 'package:dartz/dartz.dart';
import 'package:mall/core/error/failures.dart';
import 'package:mall/core/usecase/usecase.dart';
import 'package:mall/features/auth/domain/entities/auth_entity.dart';
import 'package:mall/features/auth/domain/repositories/auth_repository.dart';

class GetLastAuth implements UseCase<AuthEntity, NoParams> {
  final AuthRepository repository;

  GetLastAuth(this.repository);

  @override
  Future<Either<Failure, AuthEntity>> call(NoParams params) async {
    return await repository.getLastAuth();
  }
}
