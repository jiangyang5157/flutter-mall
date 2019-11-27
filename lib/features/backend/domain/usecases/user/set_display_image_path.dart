import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mall/core/error/failures.dart';
import 'package:mall/core/usecase/usecase.dart';
import 'package:mall/features/backend/domain/entities/user_entity.dart';
import 'package:mall/features/backend/domain/repositories/user_repository.dart';

class SetDisplayImagePath
    implements UseCase<UserEntity, SetDisplayImagePathParams> {
  final UserRepository repository;

  SetDisplayImagePath(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(
      SetDisplayImagePathParams params) async {
    return await repository.setDisplayImagePath(
      params.displayImagePath,
      entity: params.entity,
    );
  }
}

class SetDisplayImagePathParams extends Equatable {
  final String displayImagePath;
  final UserEntity entity;

  SetDisplayImagePathParams(this.displayImagePath, {this.entity})
      : super([displayImagePath, entity]);
}
