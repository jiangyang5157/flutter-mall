import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mall/core/error/failures.dart';
import 'package:mall/core/usecase/usecase.dart';
import 'package:mall/features/signup/domain/entities/sign_up_entity.dart';
import 'package:mall/features/signup/domain/repositories/sign_up_repository.dart';

class SetPassword implements UseCase<SignUpEntity, SetPasswordParams> {
  final SignUpRepository repository;

  SetPassword(this.repository);

  @override
  Future<Either<Failure, SignUpEntity>> call(SetPasswordParams params) async {
    return await repository.setPassword(params.password);
  }
}

class SetPasswordParams extends Equatable {
  final String password;

  SetPasswordParams(this.password) : super([password]);
}
