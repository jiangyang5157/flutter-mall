class ServerException implements Exception {
  final String message;

  const ServerException([this.message]);

  String toString() {
    if (message == null) return "ServerException";
    return "ServerException: $message";
  }
}

class CacheException implements Exception {}
