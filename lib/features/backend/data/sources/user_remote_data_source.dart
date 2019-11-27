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
        throw ServerException("No response returned from server.");
      } else if (!result.success) {
        throw ServerException("${result.error.message}");
      } else {
        _model = UserModel(user: result.result);
      }
    }
    return _model;
  }

  @override
  Future<UserModel> destroy(UserModel model) async {
    ParseResponse result = await model.user.destroy();
    if (result == null) {
      throw ServerException("No response returned from server.");
    } else if (!result.success) {
      throw ServerException("${result.error.message}");
    } else {
      print('#### userremotedata: destroy result: ${result.result}');
      return UserModel(user: result.result);
    }
  }

  @override
  Future<UserModel> save(UserModel model) async {
    ParseResponse result = await model.user.save();
    if (result == null) {
      throw ServerException("No response returned from server.");
    } else if (!result.success) {
      throw ServerException("${result.error.message}");
    } else {
      print('#### userremotedata: save result: ${result.result}');
      return UserModel(user: result.result);
    }
  }

  @override
  Future<UserModel> signIn(UserModel model) async {
    ParseResponse result = await model.user.login();
    if (result == null) {
      throw ServerException("No response returned from server.");
    } else if (!result.success) {
      throw ServerException("${result.error.message}");
    } else {
      print('#### userremotedata: signIn result: ${result.result}');
      return UserModel(user: result.result);
    }
  }

  @override
  Future<UserModel> signInAnonymous(UserModel model) async {
    ParseResponse result = await model.user.loginAnonymous();
    if (result == null) {
      throw ServerException("No response returned from server.");
    } else if (!result.success) {
      throw ServerException("${result.error.message}");
    } else {
      print('#### userremotedata: signInAnonymous result: ${result.result}');
      return UserModel(user: result.result);
    }
  }

  @override
  Future<UserModel> signOut(UserModel model) async {
    ParseResponse result = await model.user.logout(deleteLocalUserData: true);
    if (result == null) {
      throw ServerException("No response returned from server.");
    } else if (!result.success) {
      throw ServerException("${result.error.message}");
    } else {
      print('#### userremotedata: signOut result: ${result.result}');
      return UserModel(user: result.result);
    }
  }

  @override
  Future<UserModel> signUp(UserModel model) async {
    ParseResponse result = await model.user.signUp();
    if (result == null) {
      throw ServerException("No response returned from server.");
    } else if (!result.success) {
      throw ServerException("${result.error.message}");
    } else {
      print('#### userremotedata: signUp result: ${result.result}');
      return UserModel(user: result.result);
    }
  }
}
