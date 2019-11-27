import 'package:flutter/material.dart';
import 'package:mall/core/error/failures.dart';
import 'package:mall/features/auth/domain/entities/auth_entity.dart';
import 'package:mall/features/auth/domain/usecases/usecases.dart' as Auth;

class AuthViewModel extends ChangeNotifier {
  final Auth.GetLastAuth _gla;
  final Auth.SetAuth _sa;

  final _defaultAuth = AuthEntity(state: AuthState.SignIn);
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
      _lastAuth = _defaultAuth;
      fetchLasAuth(notify: true);
    }
    return _lastAuth;
  }

  Future<void> fetchLasAuth({bool notify = false}) async {
    Failure ret;
    await _gla.call(Auth.GetLastAuthParams()).then((result) {
      result.fold(
        (failure) => setAuth(_defaultAuth.state),
        (entity) => _lastAuth = entity,
      );
    });
    if (notify) {
      notifyListeners();
    }
    return ret;
  }

  Future<Failure> setAuth(
    AuthState state, {
    bool notify = false,
  }) async {
    Failure ret;
    await _sa.call(Auth.SetAuthParams(state)).then((result) {
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
