import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

import 'package:mall/src/pages/home/home.dart';
import 'package:mall/src/parse/parse.dart';
import 'package:mall/src/core/core.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  Future<void> initialize() async {
    // init Parse
    Parse().initialize(parseApplicationId, parseServerUrl,
        appName: parseApplicationName, masterKey: parseMasterKey, debug: true);

    // init database
    await DbProvider().initialize();

    // init repositories
    UserRepository().initialize(DbProvider().db);

    dispatch(HomeInitializedEvent());
  }

  @override
  HomeState get initialState {
    initialize();
    return HomeUninitializedState();
  }

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is HomeInitializedEvent) {
      yield HomeInitializedState();
    }

    if (event is HomeSignedInEvent) {
      yield HomeAuthenticatedState();
    }

    if (event is HomeSignedOutEvent) {
      yield HomeUnauthenticatedState();
    }
  }
}
