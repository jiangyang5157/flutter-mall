import 'package:flutter/material.dart';
import 'package:mall/core/error/failures.dart';
import 'package:mall/core/usecase/usecase.dart';
import 'package:mall/features/signup/domain/entities/sign_up_entity.dart';
import 'package:mall/features/signup/domain/usecases/usecases.dart' as SignUp;

class SignUpViewModel extends ChangeNotifier {
  final SignUp.GetData _getData;
  final SignUp.SetData _setData;
  final SignUp.SetUsername _setUsername;
  final SignUp.SetPassword _setPassword;
  final SignUp.SetRepeatPassword _setRepeatPassword;
  final SignUp.SetEmailAddress _setEmailAddress;
  final SignUp.SetObscurePassword _setObscurePassword;

  SignUpEntity _currentEntity;

  SignUpViewModel({
    @required SignUp.GetData getData,
    @required SignUp.SetData setData,
    @required SignUp.SetUsername setUsername,
    @required SignUp.SetPassword setPassword,
    @required SignUp.SetRepeatPassword setRepeatPassword,
    @required SignUp.SetEmailAddress setEmailAddress,
    @required SignUp.SetObscurePassword setObscurePassword,
  })  : assert(getData != null),
        assert(setData != null),
        assert(setUsername != null),
        assert(setPassword != null),
        assert(setRepeatPassword != null),
        assert(setEmailAddress != null),
        assert(setObscurePassword != null),
        _getData = getData,
        _setData = setData,
        _setUsername = setUsername,
        _setPassword = setPassword,
        _setRepeatPassword = setRepeatPassword,
        _setEmailAddress = setEmailAddress,
        _setObscurePassword = setObscurePassword {
    print('#### SignUpViewModel - constructor');
  }

  @override
  void dispose() {
    super.dispose();
    print('#### SignUpViewModel - dispose');
  }

  SignUpEntity getCurrentData() {
    if (_currentEntity == null) {
      // returns default first
      final defaultEntity = SignUpEntity(
        username: '',
        password: '',
        repeatPassword: '',
        emailAddress: '',
        obscurePassword: true,
      );
      _currentEntity = defaultEntity;

      _getData.call(NoParams()).then((result) {
        result.fold(
          // set default if non-exist
          (failure) => setCurrentData(
            defaultEntity.username,
            defaultEntity.password,
            defaultEntity.repeatPassword,
            defaultEntity.emailAddress,
            defaultEntity.obscurePassword,
          ),
          (entity) {
            if (_currentEntity != entity) {
              _currentEntity = entity;

              // notify only if the value is different from the default
              notifyListeners();
            }
          },
        );
      });
    }
    return _currentEntity;
  }

  Future<Failure> setCurrentData(
    String username,
    String password,
    String repeatPassword,
    String emailAddress,
    bool obscurePassword, {
    bool notify = false,
  }) async {
    Failure ret;
    await _setData
        .call(SignUp.SetDataParams(
            username: username,
            password: password,
            repeatPassword: repeatPassword,
            emailAddress: emailAddress,
            obscurePassword: obscurePassword))
        .then((result) {
      result.fold(
        (failure) => ret = failure,
        (entity) => _currentEntity = entity,
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
    await _setUsername
        .call(SignUp.SetUsernameParams(
            entity: _currentEntity, username: username))
        .then((result) {
      result.fold(
        (failure) => ret = failure,
        (entity) => _currentEntity = entity,
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
    await _setPassword
        .call(SignUp.SetPasswordParams(
            entity: _currentEntity, password: password))
        .then((result) {
      result.fold(
        (failure) => ret = failure,
        (entity) => _currentEntity = entity,
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
    await _setRepeatPassword
        .call(SignUp.SetRepeatPasswordParams(
            entity: _currentEntity, repeatPassword: repeatPassword))
        .then((result) {
      result.fold(
        (failure) => ret = failure,
        (entity) => _currentEntity = entity,
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
    await _setEmailAddress
        .call(SignUp.SetEmailAddressParams(
            entity: _currentEntity, emailAddress: emailAddress))
        .then((result) {
      result.fold(
        (failure) => ret = failure,
        (entity) => _currentEntity = entity,
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
    await _setObscurePassword
        .call(SignUp.SetObscurePasswordParams(
            entity: _currentEntity, obscurePassword: obscurePassword))
        .then((result) {
      result.fold(
        (failure) => ret = failure,
        (entity) => _currentEntity = entity,
      );
    });
    if (notify) {
      notifyListeners();
    }
    return ret;
  }
}
