import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mall/core/error/failures.dart';
import 'package:mall/core/usecase/usecase.dart';
import 'package:mall/features/signup/domain/entities/sign_up_entity.dart';
import 'package:mall/features/signup/domain/repositories/sign_up_repository.dart';

class SetEmailAddress implements UseCase<SignUpEntity, SetEmailAddressParams> {
  final SignUpRepository repository;

  SetEmailAddress(this.repository);

  @override
  Future<Either<Failure, SignUpEntity>> call(
      SetEmailAddressParams params) async {
    return await repository.setEmailAddress(params.emailAddress);
  }
}

class SetEmailAddressParams extends Equatable {
  final String emailAddress;

  SetEmailAddressParams(this.emailAddress) : super([emailAddress]);
}
