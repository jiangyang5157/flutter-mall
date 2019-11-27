import 'package:flutter/material.dart';
import 'package:mall/core/error/failures.dart';
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

  final _defaultData = SignUpEntity(
    username: '',
    password: '',
    repeatPassword: '',
    emailAddress: '',
    obscurePassword: true,
  );
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

  SignUpEntity getLastData() {
    if (_lastData == null) {
      _lastData = _defaultData;
      fetchLastData(notify: true);
    }
    return _lastData;
  }

  Future<void> fetchLastData({bool notify = false}) async {
    Failure ret;
    await _gd.call(SignUp.GetDataParams()).then((result) {
      result.fold(
        (failure) => setData(
          _defaultData.username,
          _defaultData.password,
          _defaultData.repeatPassword,
          _defaultData.emailAddress,
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

  Future<Failure> setUsername(
    String username, {
    bool notify = false,
  }) async {
    Failure ret;
    await _su.call(SignUp.SetUsernameParams(username)).then((result) {
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
    await _sp.call(SignUp.SetPasswordParams(password)).then((result) {
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

  Future<Failure> setRepeatPassword(
    String repeatPassword, {
    bool notify = false,
  }) async {
    Failure ret;
    await _srp
        .call(SignUp.SetRepeatPasswordParams(repeatPassword))
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

  Future<Failure> setEmailAddress(
    String emailAddress, {
    bool notify = false,
  }) async {
    Failure ret;
    await _sea.call(SignUp.SetEmailAddressParams(emailAddress)).then((result) {
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
        .call(SignUp.SetObscurePasswordParams(obscurePassword))
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
