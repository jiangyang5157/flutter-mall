import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mall/core/error/failures.dart';
import 'package:mall/core/usecase/usecase.dart';
import 'package:mall/features/auth/domain/entities/auth_entity.dart';
import 'package:mall/features/auth/domain/repositories/auth_repository.dart';

class GetLastAuth implements UseCase<AuthEntity, GetLastAuthParams> {
  final AuthRepository repository;

  GetLastAuth(this.repository);

  @override
  Future<Either<Failure, AuthEntity>> call(GetLastAuthParams params) async {
    return await repository.getLastAuth(fromMemory: params.fromMemory);
  }
}

class GetLastAuthParams extends Equatable {
  final bool fromMemory;

  GetLastAuthParams({this.fromMemory = true}) : super([fromMemory]);
}
