import 'package:flutter/material.dart';
import 'package:mall/core/error/failures.dart';
import 'package:mall/features/signin/domain/entities/sign_in_entity.dart';
import 'package:mall/features/signin/domain/usecases/usecases.dart' as SignIn;

class SignInViewModel extends ChangeNotifier {
  final SignIn.GetData _gd;
  final SignIn.SetData _sd;
  final SignIn.SetUsername su;
  final SignIn.SetPassword _sp;
  final SignIn.SetObscurePassword _sop;

  final _defaultData = SignInEntity(
    username: '',
    password: '',
    obscurePassword: true,
  );
  SignInEntity _lastData;

  SignInViewModel({
    @required SignIn.GetData gd,
    @required SignIn.SetData sd,
    @required SignIn.SetUsername su,
    @required SignIn.SetPassword sp,
    @required SignIn.SetObscurePassword sop,
  })  : assert(gd != null),
        assert(sd != null),
        assert(su != null),
        assert(sp != null),
        assert(sop != null),
        _gd = gd,
        _sd = sd,
        su = su,
        _sp = sp,
        _sop = sop {
    print('#### SignInViewModel - constructor');
  }

  @override
  void dispose() {
    super.dispose();
    print('#### SignInViewModel - dispose');
  }

  SignInEntity getLastData() {
    if (_lastData == null) {
      _lastData = _defaultData;
      fetchLastData(notify: true);
    }
    return _lastData;
  }

  Future<void> fetchLastData({bool notify = false}) async {
    Failure ret;
    await _gd.call(SignIn.GetDataParams()).then((result) {
      result.fold(
        (failure) => setData(
          _defaultData.username,
          _defaultData.password,
          _defaultData.obscurePassword,
        ),
        (entity) => _lastData = entity,
      );
    });
    if (notify) {
      notifyListeners();
    }
    return ret;
  }

  Future<Failure> setData(
    String username,
    String password,
    bool obscurePassword, {
    bool notify = false,
  }) async {
    Failure ret;
    await _sd
        .call(SignIn.SetDataParams(
            username: username,
            password: password,
            obscurePassword: obscurePassword))
        .then((result) {
      result.fold(
        (failure) => ret = failure,
        (entity) => _lastData = entity,
      );
    });
    if (notify) {
      notifyListeners();
    }
    return ret;
  }

  Future<Failure> setUsername(
    String username, {
    bool notify = false,
  }) async {
    Failure ret;
    await su.call(SignIn.SetUsernameParams(username)).then((result) {
      result.fold(
        (failure) => ret = failure,
        (entity) => _lastData = entity,
      );
    });
    if (notify) {
      notifyListeners();
    }
    return ret;
  }

  Future<Failure> setPassword(
    String password, {
    bool notify = false,
  }) async {
    Failure ret;
    await _sp.call(SignIn.SetPasswordParams(password)).then((result) {
      result.fold(
        (failure) => ret = failure,
        (entity) => _lastData = entity,
      );
    });
    if (notify) {
      notifyListeners();
    }
    return ret;
  }

  Future<Failure> setObscurePassword(
    bool obscurePassword, {
    bool notify = false,
  }) async {
    Failure ret;
    await _sop
        .call(SignIn.SetObscurePasswordParams(obscurePassword))
        .then((result) {
      result.fold(
        (failure) => ret = failure,
        (entity) => _lastData = entity,
      );
    });
    if (notify) {
      notifyListeners();
    }
    return ret;
  }
}
