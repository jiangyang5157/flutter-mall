import 'package:parse_server_sdk/parse_server_sdk.dart';

import 'package:mall/src/parse/parse.dart';

abstract class UserProviderContract {
  User createUser({String username, String password, String emailAddress});

  Future<User> currentUser();

  Future<ParseResponse> save(User user);

  Future forget(User user);

  Future<ParseResponse> destroy(User user);

  Future<ParseResponse> signUp(User user);

  Future<ParseResponse> signIn(User user);

  Future<ParseResponse> signOut(User user);

  Future<ParseResponse> getCurrentUserFromServer();

  Future<ParseResponse> requestPasswordReset(User user);

  Future<ParseResponse> verificationEmailRequest(User user);
}
