import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

import 'package:mall/src.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  Future<void> _sync() async {
    User user = await UserRepository().currentUser();
    if (user != null) {
      dispatch(AuthenticationSignInCurrentUserEvent());
    }
  }

  Future<void> _signUp(Future<User> user) async {
    User theUser = await user;
    ParseResponse response = await theUser.signUp();
    if (response.success) {
      dispatch(AuthenticationSignedUpEvent());
    } else {
      dispatch(AuthenticationErrorEvent(response.error.message));
    }
  }

  Future<void> _signIn(Future<User> user) async {
    User theUser = await user;
    ParseResponse response = await theUser.login();
    if (response.success) {
      dispatch(AuthenticationSignedInEvent());
    } else {
      dispatch(AuthenticationErrorEvent(response.error.message));
    }
  }

  Future<void> _signOut(Future<User> user) async {
    User theUser = await user;
    ParseResponse response = await theUser.logout();
    if (response.success) {
      dispatch(AuthenticationSignedOutEvent());
    } else {
      dispatch(AuthenticationErrorEvent(response.error.message));
    }
  }

  @override
  AuthenticationState get initialState {
    _sync();
    return AuthenticationUnauthenticatedState();
  }

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AuthenticationErrorEvent) {
      yield AuthenticationErrorState(event.message);
    }

    if (event is AuthenticationSignUpEvent) {
      _signUp(Future.value(UserRepository()
          .createUser(event.username, event.password, event.emailAddress)));
      yield AuthenticationStartState();
    }

    if (event is AuthenticationSignedUpEvent) {
      yield AuthenticationAuthenticatedState();
    }

    if (event is AuthenticationSignInEvent) {
      _signIn(Future.value(
          UserRepository().createUser(event.username, event.password)));
      yield AuthenticationStartState();
    }

    if (event is AuthenticationSignedInEvent) {
      yield AuthenticationAuthenticatedState();
    }

    if (event is AuthenticationSignInCurrentUserEvent) {
      _signIn(UserRepository().currentUser());
      yield AuthenticationStartState();
    }

    if (event is AuthenticationSignedInCurrentUserEvent) {
      yield AuthenticationAuthenticatedState();
    }

    if (event is AuthenticationSignOutEvent) {
      _signOut(UserRepository().currentUser());
      yield AuthenticationStartState();
    }

    if (event is AuthenticationSignedOutEvent) {
      yield AuthenticationUnauthenticatedState();
    }
  }
}
