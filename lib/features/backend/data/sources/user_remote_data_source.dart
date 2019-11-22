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
      print('#### current user not found from server.');
      throw ServerException();
    }

    if (!result.success) {
      print('#### current user not found from server: ${result.error.message}');
      throw ServerException();
    }
    return UserModel(user: result.result);
  }
}
