import 'package:parse_server_sdk/parse_server_sdk.dart';

abstract class UserContract {
  Future<ParseResponse> signUp();

  Future<ParseResponse> signIn();

  Future<ParseResponse> signOut();

  Future<ParseResponse> save();

  Future<ParseResponse> destroy();
}
