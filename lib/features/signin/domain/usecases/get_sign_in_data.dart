import 'package:dartz/dartz.dart';
import 'package:mall/core/error/failures.dart';
import 'package:mall/core/usecase/usecase.dart';
import 'package:mall/features/signin/domain/entities/sign_in_entity.dart';
import 'package:mall/features/signin/domain/repositories/sign_in_repository.dart';

class GetSignInData implements UseCase<SignInEntity, NoParams> {
  final SignInRepository repository;

  GetSignInData(this.repository);

  @override
  Future<Either<Failure, SignInEntity>> call(NoParams params) async {
    return await repository.getSignInData();
  }
}
