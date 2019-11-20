import 'package:flutter/material.dart';
import 'package:mall/core/usecase/usecase.dart';
import 'package:mall/features/splash/domain/usecases/usecases.dart' as Splash;

class SplashViewModel extends ChangeNotifier {
  final Splash.Initialization _initialization;

  SplashViewModel({
    @required Splash.Initialization initialization,
  })  : assert(initialization != null),
        _initialization = initialization {
    print('#### SplashViewModel - constructor');
  }

  @override
  void dispose() {
    super.dispose();
    print('#### SplashViewModel - dispose');
  }

  Future<bool> initialization() async {
    final ret = await _initialization.call(NoParams()).then((result) {
      result.fold(
        (failure) => false,
        (_) => true,
      );
    });
    return ret;
  }
}
