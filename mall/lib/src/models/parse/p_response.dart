import 'package:parse_server_sdk/parse_server_sdk.dart';

import 'parse.dart';

class PResponse {
  PResponse(this.success, this.statusCode, this.results, this.error)
      : count = results?.length ?? 0,
        result = results?.first;

  final bool success;
  final int statusCode;
  final List<dynamic> results;
  final dynamic result;
  int count;
  final PError error;
}

PResponse getResponse<T extends ParseObject>(ParseResponse response) {
  return PResponse(response.success, response.statusCode, response.results,
      getError(response.error));
}

PError getError(ParseError response) {
  if (response == null) {
    return null;
  }

  return PError(response.code, response.message, response.isTypeOfException,
      response.type);
}
