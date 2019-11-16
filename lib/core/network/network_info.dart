import 'package:data_connection_checker/data_connection_checker.dart';

abstract class NetworkConnection {
  Future<bool> get isConnected;
}

class NetworkInfo implements NetworkConnection {
  final DataConnectionChecker connectionChecker;

  NetworkInfo(this.connectionChecker);

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
}
