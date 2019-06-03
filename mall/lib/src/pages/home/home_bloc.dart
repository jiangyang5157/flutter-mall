import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:mall/src/pages/home/home.dart';
import 'package:mall/src/parse/parse.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  Future initialize() async {}

  @override
  HomeState get initialState {
    initialize();
    return InitialHomeState();
  }

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is SignOutEvent) {
      yield SignOutStartState();

      User user = await UserRepository().currentUser();
      await user?.logout();
      yield SignOutFinishState();
    }
  }
}
