import 'package:sembast/sembast.dart';
import 'package:mall/src/models/parse/parse.dart';
import 'parse.dart';

class UserRepository implements UserProvider {
  static UserRepository init(Database dbConnection,
      {UserProvider mockDbProvider, UserProvider mockApiProvider}) {
    final UserRepository repository = UserRepository();

    if (mockDbProvider != null) {
      repository.db = mockDbProvider;
    } else {
      final Store store = dbConnection.getStore(_db_store_User);
      repository.db = DbUserProvider(dbConnection, store);
    }

    if (mockApiProvider != null) {
      repository.api = mockApiProvider;
    } else {
      repository.api = ApiUserProvider();
    }

    return repository;
  }

  UserProvider api;
  UserProvider db;

  static const String _db_store_User = '_db_store_User';

  @override
  Future<PUser> createUser(
      String username, String password, String emailAddress) async {
    api.createUser(username, password, emailAddress);

    final PUser user = await api.createUser(username, password, emailAddress);
    if (user != null) {
      await db.createUser(username, password, emailAddress);
    }

    return user;
  }

  @override
  Future<PUser> currentUser() => db.currentUser();

  @override
  Future<ApiResponse> destroy(PUser user) async {
    ApiResponse response = await api.destroy(user);
    response = await db.destroy(user);
    return response;
  }

  @override
  Future<ApiResponse> allUsers() => api.allUsers();

  @override
  Future<ApiResponse> getCurrentUserFromServer() =>
      api.getCurrentUserFromServer();

  @override
  Future<ApiResponse> login(PUser user) => api.login(user);

  @override
  void logout(PUser user) => api.logout(user);

  @override
  Future<ApiResponse> requestPasswordReset(PUser user) =>
      api.requestPasswordReset(user);

  @override
  Future<ApiResponse> save(PUser user) async {
    ApiResponse response = await api.save(user);
    response = await db.save(user);
    return response;
  }

  @override
  Future<ApiResponse> signUp(PUser user) => api.signUp(user);

  @override
  Future<ApiResponse> verificationEmailRequest(PUser user) => api.signUp(user);
}
