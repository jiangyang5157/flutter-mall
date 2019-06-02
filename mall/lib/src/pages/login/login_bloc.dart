import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

import 'package:mall/src/pages/login/login.dart';
import 'package:mall/src/parse/parse.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  Future<void> initialize() async {
    User user = await UserRepository().currentUser();
    if (user != null) {
      dispatch(LoginSignInCurrentUserEvent(user));
    }
  }

  @override
  LoginState get initialState {
    initialize();
    return LoginInitialState();
  }

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginSignUpEvent) {
      yield LoginStartState();

      User user = UserRepository()
          .createUser(event.username, event.password, event.emailAddress);
      ParseResponse response = await user.signUp();
      if (response.success) {
        yield LoginSuccessState();
      } else {
        yield LoginFailureState(response.error.message);
      }
    }

    if (event is LoginSignInEvent) {
      yield LoginStartState();

      User user = UserRepository().createUser(event.username, event.password);
      ParseResponse response = await user.login();
      if (response.success) {
        yield LoginSuccessState();
      } else {
        yield LoginFailureState(response.error.message);
      }
    }

    if (event is LoginSignInCurrentUserEvent) {
      yield LoginCurrentUserStartState(event.user);

      ParseResponse response = await event.user.login();
      if (response.success) {
        yield LoginSuccessState();
      } else {
        yield LoginFailureState(response.error.message);
      }
    }
  }
}
