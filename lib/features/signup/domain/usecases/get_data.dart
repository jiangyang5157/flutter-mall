import 'package:dartz/dartz.dart';
import 'package:mall/core/error/failures.dart';
import 'package:mall/core/usecase/usecase.dart';
import 'package:mall/features/signup/domain/entities/sign_up_entity.dart';
import 'package:mall/features/signup/domain/repositories/sign_up_repository.dart';

class GetData implements UseCase<SignUpEntity, NoParams> {
  final SignUpRepository repository;

  GetData(this.repository);

  @override
  Future<Either<Failure, SignUpEntity>> call(NoParams params) async {
    return await repository.getData();
  }
}
