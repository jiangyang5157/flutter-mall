import 'package:mall/src/models/parse/parse.dart';

abstract class UserProvider {
  Future<PUser> createUser(
      String username, String password, String emailAddress);

  Future<PUser> currentUser();

  Future<ApiResponse> signUp(PUser user);

  Future<ApiResponse> login(PUser user);

  void logout(PUser user);

  Future<ApiResponse> getCurrentUserFromServer();

  Future<ApiResponse> requestPasswordReset(PUser user);

  Future<ApiResponse> verificationEmailRequest(PUser user);

  Future<ApiResponse> save(PUser user);

  Future<ApiResponse> destroy(PUser user);

  Future<ApiResponse> allUsers();
}
