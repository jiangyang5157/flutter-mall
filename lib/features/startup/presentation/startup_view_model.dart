import 'package:flutter/material.dart';
import 'package:mall/core/usecase/usecase.dart';
import 'package:mall/features/backend/domain/usecases/server/usecases.dart' as Server;

class StartupViewModel extends ChangeNotifier {
  final Server.Initialization _initialization;

  StartupViewModel({
    @required Server.Initialization initialization,
  })  : assert(initialization != null),
        _initialization = initialization {
    print('#### StartupViewModel - constructor');
  }

  @override
  void dispose() {
    super.dispose();
    print('#### StartupViewModel - dispose');
  }

  Future<bool> initialization() async {
    bool ret;
    await _initialization.call(NoParams()).then((result) {
      result.fold(
        (failure) => ret = false,
        (_) => ret = true,
      );
    });
    return ret;
  }
}
