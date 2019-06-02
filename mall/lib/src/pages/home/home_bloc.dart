import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:mall/src/pages/home/home.dart';
import 'package:mall/src/parse/parse.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  Future<void> initialize() async {}

  @override
  HomeState get initialState {
    initialize();
    return HomeInitialState();
  }

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is HomeSignOutEvent) {
      yield HomeLogoutStartState();

      User user = await UserRepository().currentUser();
      await user.logout();
      yield HomeLogoutCompletedState();
    }
  }
}
