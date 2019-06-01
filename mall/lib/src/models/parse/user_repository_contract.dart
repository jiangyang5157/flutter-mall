import 'package:parse_server_sdk/parse_server_sdk.dart';

import 'package:mall/src.dart';

abstract class UserProviderContract {
  User createUser(String username, String password, String emailAddress);

  Future<ParseResponse> save(User user);

  Future<ParseResponse> destroy(User user);

  Future<ParseResponse> signUp(User user);

  Future<ParseResponse> signIn(User user);

  Future<ParseResponse> signOut(User user);

  Future<dynamic> currentUser();

  Future<ParseResponse> getCurrentUserFromServer();

  Future<ParseResponse> requestPasswordReset(User user);

  Future<ParseResponse> verificationEmailRequest(User user);
}
