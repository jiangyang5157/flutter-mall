import 'package:flutter/material.dart';
import 'package:mall/core/usecase/usecase.dart';
import 'package:mall/features/signin/domain/entities/sign_in_entity.dart';
import 'package:mall/features/signin/domain/usecases/usecases.dart' as SignIn;

class SignInViewModel extends ChangeNotifier {
  final SignIn.GetData _getData;
  final SignIn.SetData _setData;
  final SignIn.SetUsername _setUsername;
  final SignIn.SetPassword _setPassword;
  final SignIn.SetObscurePassword _setObscurePassword;

  SignInEntity _entity;

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
        .call(SignIn.SetDataParams(
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
        .call(SignIn.SetUsernameParams(entity: _entity, username: username))
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
        .call(SignIn.SetPasswordParams(entity: _entity, password: password))
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
        .call(SignIn.SetObscurePasswordParams(
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
