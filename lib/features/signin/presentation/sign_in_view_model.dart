import 'package:flutter/material.dart';
import 'package:mall/core/error/failures.dart';
import 'package:mall/core/usecase/usecase.dart';
import 'package:mall/features/signin/domain/entities/sign_in_entity.dart';
import 'package:mall/features/signin/domain/usecases/usecases.dart' as SignIn;

class SignInViewModel extends ChangeNotifier {
  final SignIn.GetData _gd;
  final SignIn.SetData _sd;
  final SignIn.SetUsername su;
  final SignIn.SetPassword _sp;
  final SignIn.SetObscurePassword _sop;

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
      // returns default first
      final defaultEntity = SignInEntity(
        username: '',
        password: '',
        obscurePassword: true,
      );
      _lastData = defaultEntity;

      _gd.call(NoParams()).then((result) {
        result.fold(
          // set default if non-exist
          (failure) => setData(
            defaultEntity.username,
            defaultEntity.password,
            defaultEntity.obscurePassword,
          ),
          (entity) {
            if (_lastData != entity) {
              _lastData = entity;

              // notify only if the value is different from the default
              notifyListeners();
            }
          },
        );
      });
    }
    return _lastData;
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

  Future<Failure> setCurrentUsername(
    String username, {
    bool notify = false,
  }) async {
    Failure ret;
    await su.call(SignIn.SetUsernameParams(username: username)).then((result) {
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

  Future<Failure> setCurrentPassword(
    String password, {
    bool notify = false,
  }) async {
    Failure ret;
    await _sp.call(SignIn.SetPasswordParams(password: password)).then((result) {
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

  Future<Failure> setCurrentObscurePassword(
    bool obscurePassword, {
    bool notify = false,
  }) async {
    Failure ret;
    await _sop
        .call(SignIn.SetObscurePasswordParams(obscurePassword: obscurePassword))
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
