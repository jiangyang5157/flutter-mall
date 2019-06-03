import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

import 'package:mall/src/pages/login/login.dart';
import 'package:mall/src/parse/parse.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  Future<void> initialize() async {
    User user = await UserRepository().currentUser();
    if (user != null) {
      dispatch(CurrentUserFoundEvent(user));
    }
  }

  @override
  LoginState get initialState {
    initialize();
    return InitialLoginState();
  }

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is SignUpEvent) {
      yield SignUpStartState();

      User user = UserRepository().createUser(
          username: event.username,
          password: event.password,
          emailAddress: event.emailAddress);
      ParseResponse response = await user.signUp();
      if (response.success) {
        yield SignUpSuccessState();
      } else {
        yield SignUpFailureState(response.error.message);
      }
    }

    if (event is SignInEvent) {
      yield SignInStartState();

      User user = UserRepository()
          .createUser(username: event.username, password: event.password);
      ParseResponse response = await user.login();
      if (response.success) {
        yield SignInSuccessState();
      } else {
        yield SignInFailureState(response.error.message);
      }
    }

    if (event is CurrentUserFoundEvent) {
      yield InitialLoginState(event.user);
    }
  }
}
