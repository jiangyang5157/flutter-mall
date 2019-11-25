import 'package:flutter/material.dart';
import 'package:mall/core/error/failures.dart';
import 'package:mall/core/usecase/usecase.dart';
import 'package:mall/features/signin/domain/entities/sign_in_entity.dart';
import 'package:mall/features/signin/domain/usecases/usecases.dart' as SignIn;

class SignInViewModel extends ChangeNotifier {
  final SignIn.GetData _getData;
  final SignIn.SetData _setData;
  final SignIn.SetUsername _setUsername;
  final SignIn.SetPassword _setPassword;
  final SignIn.SetObscurePassword _setObscurePassword;

  SignInEntity _currentEntity;

  SignInViewModel({
    @required SignIn.GetData getData,
    @required SignIn.SetData setData,
    @required SignIn.SetUsername setUsername,
    @required SignIn.SetPassword setPassword,
    @required SignIn.SetObscurePassword setObscurePassword,
  })  : assert(getData != null),
        assert(setData != null),
        assert(setUsername != null),
        assert(setPassword != null),
        assert(setObscurePassword != null),
        _getData = getData,
        _setData = setData,
        _setUsername = setUsername,
        _setPassword = setPassword,
        _setObscurePassword = setObscurePassword {
    print('#### SignInViewModel - constructor');
  }

  @override
  void dispose() {
    super.dispose();
    print('#### SignInViewModel - dispose');
  }

  SignInEntity getCurrentData() {
    if (_currentEntity == null) {
      // returns default first
      final defaultEntity =
          SignInEntity(username: '', password: '', obscurePassword: true);
      _currentEntity = defaultEntity;

      _getData.call(NoParams()).then((result) {
        result.fold(
          // set default if non-exist
          (failure) => setCurrentData(
            defaultEntity.username,
            defaultEntity.password,
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
    bool obscurePassword, {
    bool notify = false,
  }) async {
    Failure ret;
    await _setData
        .call(SignIn.SetDataParams(
            username: username,
            password: password,
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
        .call(SignIn.SetUsernameParams(
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
        .call(SignIn.SetPasswordParams(
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

  Future<Failure> setObscurePassword(
    bool obscurePassword, {
    bool notify = false,
  }) async {
    Failure ret;
    await _setObscurePassword
        .call(SignIn.SetObscurePasswordParams(
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
