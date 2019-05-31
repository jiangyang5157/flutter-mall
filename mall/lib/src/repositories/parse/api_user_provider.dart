import 'package:parse_server_sdk/parse_server_sdk.dart';

import 'package:mall/src.dart';

class ApiUserProvider implements UserProvider {
  @override
  Future<PUser> createUser(
      String username, String password, String emailAddress) {
    return Future<PUser>.value(PUser(username, password, emailAddress));
  }

  @override
  Future<PUser> currentUser() {
    return ParseUser.currentUser();
  }

  @override
  Future<ApiResponse> getCurrentUserFromServer() async {
    return getApiResponse<PUser>(await ParseUser.getCurrentUserFromServer());
  }

  @override
  Future<ApiResponse> destroy(PUser user) async {
    return getApiResponse<PUser>(await user.destroy());
  }

  @override
  Future<ApiResponse> login(PUser user) async {
    return getApiResponse<PUser>(await user.login());
  }

  @override
  Future<ApiResponse> requestPasswordReset(PUser user) async {
    return getApiResponse<PUser>(await user.requestPasswordReset());
  }

  @override
  Future<ApiResponse> save(PUser user) async {
    return getApiResponse<PUser>(await user.save());
  }

  @override
  Future<ApiResponse> signUp(PUser user) async {
    return getApiResponse<PUser>(await user.signUp());
  }

  @override
  Future<ApiResponse> verificationEmailRequest(PUser user) async {
    return getApiResponse<PUser>(await user.verificationEmailRequest());
  }

  @override
  Future<ApiResponse> allUsers() async {
    return getApiResponse(await ParseUser.all());
  }

  @override
  void logout(PUser user) => user.logout();
}
