import 'package:flutter/material.dart';
import 'package:mall/core/error/failures.dart';
import 'package:mall/core/usecase/usecase.dart';
import 'package:mall/features/signin/domain/entities/sign_in_entity.dart';
import 'package:mall/features/signin/domain/usecases/get_sign_in_data.dart';
import 'package:mall/features/signin/domain/usecases/set_obscure_password.dart';
import 'package:mall/features/signin/domain/usecases/set_password.dart';
import 'package:mall/features/signin/domain/usecases/set_sign_in_data.dart';
import 'package:mall/features/signin/domain/usecases/set_username.dart';

class SignInViewModel extends ChangeNotifier {
  final GetSignInData _getSignInData;
  final SetSignInData _setSignInData;
  final SetUsername _setUsername;
  final SetPassword _setPassword;
  final SetObscurePassword _setObscurePassword;

  SignInEntity _entity;

  SignInViewModel({
    @required GetSignInData getSignInData,
    @required SetSignInData setSignInData,
    @required SetUsername setUsername,
    @required SetPassword setPassword,
    @required SetObscurePassword setObscurePassword,
  })  : assert(getSignInData != null),
        assert(setSignInData != null),
        assert(setUsername != null),
        assert(setPassword != null),
        assert(setObscurePassword != null),
        _getSignInData = getSignInData,
        _setSignInData = setSignInData,
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

  SignInEntity getCurrentSignInData() {
    if (_entity == null) {
      // returns default first
      final defaultEntity =
          SignInEntity(username: '', password: '', obscurePassword: true);
      _entity = defaultEntity;

      _getSignInData.call(NoParams()).then((result) {
        result.fold(
          (failure) {
            // set default if non-exist
            setCurrentSignInData(defaultEntity.username, defaultEntity.password,
                defaultEntity.obscurePassword,
                notify: false);
          },
          (entity) {
            if (_entity != entity) {
              _entity = entity;

              // notify only if the value is different from the default
              notifyListeners();
            }
          },
        );
      });
    }
    return _entity;
  }

  Future<void> setCurrentSignInData(
      String username, String password, bool obscurePassword,
      {@required bool notify}) async {
    await _setSignInData
        .call(SetSignInDataParams(
            username: username,
            password: password,
            obscurePassword: obscurePassword))
        .then((result) {
      _entity = result.fold(
        (failure) => throw CacheFailure(),
        (entity) => entity,
      );
    });
    if (notify) {
      notifyListeners();
    }
  }

  Future<void> setUsername(String username, {@required bool notify}) async {
    await _setUsername
        .call(SetUsernameParams(entity: _entity, username: username))
        .then((result) {
      _entity = result.fold(
        (failure) => throw CacheFailure(),
        (entity) => entity,
      );
    });
    if (notify) {
      notifyListeners();
    }
  }

  Future<void> setPassword(String password, {@required bool notify}) async {
    await _setPassword
        .call(SetPasswordParams(entity: _entity, password: password))
        .then((result) {
      _entity = result.fold(
        (failure) => throw CacheFailure(),
        (entity) => entity,
      );
    });
    if (notify) {
      notifyListeners();
    }
  }

  Future<void> setObscurePassword(bool obscurePassword,
      {@required bool notify}) async {
    await _setObscurePassword
        .call(SetObscurePasswordParams(
            entity: _entity, obscurePassword: obscurePassword))
        .then((result) {
      _entity = result.fold(
        (failure) => throw CacheFailure(),
        (entity) => entity,
      );
    });
    if (notify) {
      notifyListeners();
    }
  }
}
