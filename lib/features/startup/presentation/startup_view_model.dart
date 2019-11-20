import 'package:flutter/material.dart';
import 'package:mall/core/usecase/usecase.dart';
import 'package:mall/features/backend/domain/usecases/usecases.dart' as Backend;

class StartupViewModel extends ChangeNotifier {
  final Backend.Initialization _initialization;

  StartupViewModel({
    @required Backend.Initialization initialization,
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
