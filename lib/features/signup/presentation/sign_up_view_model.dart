import 'package:flutter/material.dart';
import 'package:mall/core/error/failures.dart';
import 'package:mall/core/usecase/usecase.dart';
import 'package:mall/features/signup/domain/entities/sign_up_entity.dart';
import 'package:mall/features/signup/domain/usecases/usecases.dart' as SignUp;

class SignUpViewModel extends ChangeNotifier {
  final SignUp.GetData _gd;
  final SignUp.SetData _sd;
  final SignUp.SetUsername _su;
  final SignUp.SetPassword _sp;
  final SignUp.SetRepeatPassword _srp;
  final SignUp.SetEmailAddress _sea;
  final SignUp.SetObscurePassword _sop;

  SignUpEntity _lastData;

  SignUpViewModel({
    @required SignUp.GetData gd,
    @required SignUp.SetData sd,
    @required SignUp.SetUsername su,
    @required SignUp.SetPassword sp,
    @required SignUp.SetRepeatPassword srp,
    @required SignUp.SetEmailAddress sea,
    @required SignUp.SetObscurePassword sop,
  })  : assert(gd != null),
        assert(sd != null),
        assert(su != null),
        assert(sp != null),
        assert(srp != null),
        assert(sea != null),
        assert(sop != null),
        _gd = gd,
        _sd = sd,
        _su = su,
        _sp = sp,
        _srp = srp,
        _sea = sea,
        _sop = sop {
    print('#### SignUpViewModel - constructor');
  }

  @override
  void dispose() {
    super.dispose();
    print('#### SignUpViewModel - dispose');
  }

  SignUpEntity getCurrentData() {
    if (_lastData == null) {
      // returns default first
      final defaultEntity = SignUpEntity(
        username: '',
        password: '',
        repeatPassword: '',
        emailAddress: '',
        obscurePassword: true,
      );
      _lastData = defaultEntity;

      _gd.call(NoParams()).then((result) {
        result.fold(
          // set default if non-exist
          (failure) => setData(
            defaultEntity.username,
            defaultEntity.password,
            defaultEntity.repeatPassword,
            defaultEntity.emailAddress,
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
    String repeatPassword,
    String emailAddress,
    bool obscurePassword, {
    bool notify = false,
  }) async {
    Failure ret;
    await _sd
        .call(SignUp.SetDataParams(
            username: username,
            password: password,
            repeatPassword: repeatPassword,
            emailAddress: emailAddress,
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
    await _su.call(SignUp.SetUsernameParams(username: username)).then((result) {
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
    await _sp.call(SignUp.SetPasswordParams(password: password)).then((result) {
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

  Future<Failure> setCurrentRepeatPassword(
    String repeatPassword, {
    bool notify = false,
  }) async {
    Failure ret;
    await _srp
        .call(SignUp.SetRepeatPasswordParams(repeatPassword: repeatPassword))
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

  Future<Failure> setCurrentEmailAddress(
    String emailAddress, {
    bool notify = false,
  }) async {
    Failure ret;
    await _sea
        .call(SignUp.SetEmailAddressParams(emailAddress: emailAddress))
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

  Future<Failure> setCurrentObscurePassword(
    bool obscurePassword, {
    bool notify = false,
  }) async {
    Failure ret;
    await _sop
        .call(SignUp.SetObscurePasswordParams(obscurePassword: obscurePassword))
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
