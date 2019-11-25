import 'package:mall/core/error/exceptions.dart';
import 'package:mall/features/backend/data/models/user_model.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

abstract class UserRemoteDataSource {
  /// Throws a [ServerException] for all error codes.
  Future<UserModel> getLastData();

  /// Throws a [ServerException]
  Future<void> destroy(UserModel model);

  /// Throws a [ServerException]
  Future<void> save(UserModel model);

  /// Throws a [ServerException]
  Future<void> signIn(UserModel model);

  /// Throws a [ServerException]
  Future<void> signInAnonymous(UserModel model);

  /// Throws a [ServerException]
  Future<void> signOut(UserModel model);

  /// Throws a [ServerException]
  Future<void> signUp(UserModel model);
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

  @override
  Future<void> destroy(UserModel model) async {
    ParseResponse result = await model.user.destroy();
    if (!result.success) {
      throw ServerException("Destroy user failed: ${result.error.message}");
    }
  }

  @override
  Future<void> save(UserModel model) async {
    ParseResponse result = await model.user.save();
    if (!result.success) {
      throw ServerException("Save user failed: ${result.error.message}");
    }
  }

  @override
  Future<void> signIn(UserModel model) async {
    ParseResponse result = await model.user.login();
    if (!result.success) {
      throw ServerException("Sign in user failed: ${result.error.message}");
    }
  }

  @override
  Future<void> signInAnonymous(UserModel model) async {
    ParseResponse result = await model.user.loginAnonymous();
    if (!result.success) {
      throw ServerException(
          "Sign in anonymous user failed: ${result.error.message}");
    }
  }

  @override
  Future<void> signOut(UserModel model) async {
    ParseResponse result = await model.user.logout(deleteLocalUserData: true);
    if (!result.success) {
      throw ServerException("Sign out user failed: ${result.error.message}");
    }
  }

  @override
  Future<void> signUp(UserModel model) async {
    ParseResponse result = await model.user.signUp();
    if (!result.success) {
      throw ServerException("Sign up user failed: ${result.error.message}");
    }
  }
}
