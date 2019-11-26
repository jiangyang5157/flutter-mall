import 'package:flutter/material.dart';
import 'package:mall/core/error/failures.dart';
import 'package:mall/core/usecase/usecase.dart';
import 'package:mall/features/auth/domain/entities/auth_entity.dart';
import 'package:mall/features/auth/domain/usecases/usecases.dart' as Auth;

class AuthViewModel extends ChangeNotifier {
  final Auth.GetLastAuth _gla;
  final Auth.SetAuth _sa;

  AuthEntity _lastAuth;

  AuthViewModel({
    @required Auth.GetLastAuth gla,
    @required Auth.SetAuth sa,
  })  : assert(gla != null),
        assert(sa != null),
        _gla = gla,
        _sa = sa {
    print('#### AuthViewModel - constructor');
  }

  @override
  void dispose() {
    super.dispose();
    print('#### AuthViewModel - dispose');
  }

  AuthEntity getLastAuth() {
    if (_lastAuth == null) {
      // returns default first
      final defaultEntity = AuthEntity(state: AuthState.SignIn);
      _lastAuth = defaultEntity;

      _gla.call(NoParams()).then((result) {
        result.fold(
          // set default if non-exist
          (failure) => setAuth(defaultEntity.state),
          (entity) {
            if (_lastAuth != entity) {
              _lastAuth = entity;

              // notify only if the value is different from the default
              notifyListeners();
            }
          },
        );
      });
    }
    return _lastAuth;
  }

  Future<Failure> setAuth(
    AuthState state, {
    bool notify = false,
  }) async {
    Failure ret;
    await _sa.call(Auth.SetAuthParams(state: state)).then((result) {
      result.fold(
        (failure) => ret = failure,
        (entity) => _lastAuth = entity,
      );
    });
    if (notify) {
      notifyListeners();
    }
    return ret;
  }
}
