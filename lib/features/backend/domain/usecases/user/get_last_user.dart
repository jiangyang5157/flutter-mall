import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mall/core/error/failures.dart';
import 'package:mall/core/usecase/usecase.dart';
import 'package:mall/features/backend/domain/entities/user_entity.dart';
import 'package:mall/features/backend/domain/repositories/user_repository.dart';

class GetLastUser implements UseCase<UserEntity, GetLastUserParams> {
  final UserRepository repository;

  GetLastUser(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(GetLastUserParams params) async {
    return await repository.getLastUser(fromMemory: params.fromMemory);
  }
}

class GetLastUserParams extends Equatable {
  final bool fromMemory;

  GetLastUserParams({this.fromMemory = true}) : super([fromMemory]);
}
