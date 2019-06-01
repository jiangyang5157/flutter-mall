import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

import 'package:mall/src/pages/login/login.dart';
import 'package:mall/src/pages/app/app.dart';
import 'package:mall/src/pages/home/home.dart';
import 'package:mall/src/parse/parse.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final HomeBloc appBloc;

  LoginBloc(this.appBloc) : assert(appBloc != null);

  @override
  LoginState get initialState {
    return LoginInitialState();
  }

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is SignUpEvent) {
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

    if (event is SignInEvent) {
      yield LoginStartState();

      User user = UserRepository().createUser(event.username, event.password);
      ParseResponse response = await user.login();
      if (response.success) {
        yield LoginSuccessState();
      } else {
        yield LoginFailureState(response.error.message);
      }
    }
  }
}
