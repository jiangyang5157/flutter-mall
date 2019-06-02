import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

import 'package:mall/src/pages/login/login.dart';
import 'package:mall/src/parse/parse.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  Future<void> initialize() async {
    User user = await UserRepository().currentUser();
    if (user != null) {
      dispatch(CurrentUserSignInEvent(user));
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
      yield StartSignUpState();

      User user = UserRepository()
          .createUser(event.username, event.password, event.emailAddress);
      ParseResponse response = await user.signUp();
      if (response.success) {
        yield SignUpSuccessState();
      } else {
        yield SignUpFailureState(response.error.message);
      }
    }

    if (event is SignInEvent) {
      yield StartSignInState();

      User user = UserRepository().createUser(event.username, event.password);
      ParseResponse response = await user.login();
      if (response.success) {
        yield SignInSuccessState();
      } else {
        yield SignInFailureState(response.error.message);
      }
    }

    if (event is CurrentUserSignInEvent) {
      yield InitialLoginState(event.user);

      ParseResponse response = await event.user.login();
      if (response.success) {
        yield SignInSuccessState();
      } else {
        yield SignInFailureState(response.error.message);
      }
    }
  }
}
