import 'package:mall/core/error/exceptions.dart';
import 'package:mall/features/backend/data/models/user_model.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

abstract class UserRemoteDataSource {
  /// Throws a [ServerException] for all error codes.
  Future<UserModel> getLastData();
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  @override
  Future<UserModel> getLastData() async {
    ParseResponse result = await ParseUser.getCurrentUserFromServer();
    if (result == null) {
      throw ServerException("Current user cannot be found from server.");
    }

    if (!result.success) {
      throw ServerException(
          "Current user cannot be found from server: ${result.error.message}");
    }
    return UserModel(user: result.result);
  }
}
