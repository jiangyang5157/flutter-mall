import 'package:flutter/material.dart';
import 'package:mall/core/usecase/usecase.dart';
import 'package:mall/features/signin/domain/entities/sign_in_entity.dart';
import 'package:mall/features/signin/domain/usecases/usecases.dart';

class SignInViewModel extends ChangeNotifier {
  final GetData _getData;
  final SetData _setData;
  final SetUsername _setUsername;
  final SetPassword _setPassword;
  final SetObscurePassword _setObscurePassword;

  SignInEntity _entity;

  SignInViewModel({
    @required GetData getData,
    @required SetData setData,
    @required SetUsername setUsername,
    @required SetPassword setPassword,
    @required SetObscurePassword setObscurePassword,
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
    if (_entity == null) {
      // returns default first
      final defaultEntity =
          SignInEntity(username: '', password: '', obscurePassword: true);
      _entity = defaultEntity;

      _getData.call(NoParams()).then((result) {
        result.fold(
          (failure) {
            // set default if non-exist
            setCurrentData(defaultEntity.username, defaultEntity.password,
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

  Future<void> setCurrentData(
      String username, String password, bool obscurePassword,
      {@required bool notify}) async {
    await _setData
        .call(SetDataParams(
            username: username,
            password: password,
            obscurePassword: obscurePassword))
        .then((result) {
      result.fold(
        (failure) => {},
        (entity) => _entity = entity,
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
      result.fold(
        (failure) => {},
        (entity) => _entity = entity,
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
      result.fold(
        (failure) => {},
        (entity) => _entity = entity,
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
      result.fold(
        (failure) => {},
        (entity) => _entity = entity,
      );
    });
    if (notify) {
      notifyListeners();
    }
  }
}
