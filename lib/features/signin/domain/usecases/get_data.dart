import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mall/core/error/failures.dart';
import 'package:mall/core/usecase/usecase.dart';
import 'package:mall/features/signin/domain/entities/sign_in_entity.dart';
import 'package:mall/features/signin/domain/repositories/sign_in_repository.dart';

class GetData implements UseCase<SignInEntity, GetDataParams> {
  final SignInRepository repository;

  GetData(this.repository);

  @override
  Future<Either<Failure, SignInEntity>> call(GetDataParams params) async {
    return await repository.getData(fromMemory: params.fromMemory);
  }
}

class GetDataParams extends Equatable {
  final bool fromMemory;

  GetDataParams({this.fromMemory = true}) : super([fromMemory]);
}
