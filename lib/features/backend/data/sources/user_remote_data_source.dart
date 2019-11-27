import 'package:mall/core/error/exceptions.dart';
import 'package:mall/features/backend/data/models/user_model.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

abstract class UserRemoteDataSource {
  /// Throws a [ServerException] for all error codes.
  Future<UserModel> getLastUser({bool fromMemory = true});

  /// Throws a [ServerException]
  Future<UserModel> destroy(UserModel model);

  /// Throws a [ServerException]
  Future<UserModel> save(UserModel model);

  /// Throws a [ServerException]
  Future<UserModel> signIn(UserModel model);

  /// Throws a [ServerException]
  Future<UserModel> signInAnonymous(UserModel model);

  /// Throws a [ServerException]
  Future<UserModel> signOut(UserModel model);

  /// Throws a [ServerException]
  Future<UserModel> signUp(UserModel model);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  UserModel _model;

  @override
  Future<UserModel> getLastUser({bool fromMemory = true}) async {
    if (_model == null || !fromMemory) {
      ParseResponse result = await ParseUser.getCurrentUserFromServer();
      if (result == null) {
        throw ServerException("Current user cannot be found from server.");
      } else if (!result.success) {
        throw ServerException(
            "Current user cannot be found from server: ${result.error.message}");
      } else {
        _model = UserModel(user: result.result);
      }
    }
    return _model;
  }

  @override
  Future<UserModel> destroy(UserModel model) async {
    ParseResponse result = await model.user.destroy();
    if (!result.success) {
      throw ServerException("Destroy user failed: ${result.error.message}");
    }
    return result.result;
  }

  @override
  Future<UserModel> save(UserModel model) async {
    ParseResponse result = await model.user.save();
    if (!result.success) {
      throw ServerException("Save user failed: ${result.error.message}");
    }
    return result.result;
  }

  @override
  Future<UserModel> signIn(UserModel model) async {
    ParseResponse result = await model.user.login();
    if (!result.success) {
      throw ServerException("Sign in user failed: ${result.error.message}");
    }
    return result.result;
  }

  @override
  Future<UserModel> signInAnonymous(UserModel model) async {
    ParseResponse result = await model.user.loginAnonymous();
    if (!result.success) {
      throw ServerException(
          "Sign in anonymous user failed: ${result.error.message}");
    }
    return result.result;
  }

  @override
  Future<UserModel> signOut(UserModel model) async {
    ParseResponse result = await model.user.logout(deleteLocalUserData: true);
    if (!result.success) {
      throw ServerException("Sign out user failed: ${result.error.message}");
    }
    return result.result;
  }

  @override
  Future<UserModel> signUp(UserModel model) async {
    ParseResponse result = await model.user.signUp();
    if (!result.success) {
      throw ServerException("Sign up user failed: ${result.error.message}");
    }
    return result.result;
  }
}
