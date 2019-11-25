import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  Failure([List properties = const <dynamic>[]]) : super(properties);
}

class ServerFailure extends Failure {
  final String message;

  ServerFailure([this.message]) : super([message]);

  String toString() {
    if (message == null) return "ServerFailure";
    return "ServerFailure: $message";
  }
}

class CacheFailure extends Failure {}
