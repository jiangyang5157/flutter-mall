import 'package:flutter/material.dart';
import 'package:mall/core/error/failures.dart';
import 'package:mall/core/usecase/usecase.dart';
import 'package:mall/features/signup/domain/entities/sign_up_entity.dart';
import 'package:mall/features/signup/domain/usecases/usecases.dart';

class SignUpViewModel extends ChangeNotifier {
  final GetData _getData;
  final SetData _setData;
  final SetUsername _setUsername;
  final SetPassword _setPassword;
  final SetRepeatPassword _setRepeatPassword;
  final SetEmailAddress _setEmailAddress;
  final SetObscurePassword _setObscurePassword;

  SignUpEntity _entity;

  SignUpViewModel({
    @required GetData getData,
    @required SetData setData,
    @required SetUsername setUsername,
    @required SetPassword setPassword,
    @required SetRepeatPassword setRepeatPassword,
    @required SetEmailAddress setEmailAddress,
    @required SetObscurePassword setObscurePassword,
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
    if (_entity == null) {
      // returns default first
      final defaultEntity = SignUpEntity(
          username: '',
          password: '',
          repeatPassword: '',
          emailAddress: '',
          obscurePassword: true);
      _entity = defaultEntity;

      _getData.call(NoParams()).then((result) {
        result.fold(
          (failure) {
            // set default if non-exist
            setCurrentData(
                defaultEntity.username,
                defaultEntity.password,
                defaultEntity.repeatPassword,
                defaultEntity.emailAddress,
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

  Future<void> setCurrentData(String username, String password,
      String repeatPassword, String emailAddress, bool obscurePassword,
      {@required bool notify}) async {
    await _setData
        .call(SetDataParams(
            username: username,
            password: password,
            repeatPassword: repeatPassword,
            emailAddress: emailAddress,
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

  Future<void> setRepeatPassword(String repeatPassword,
      {@required bool notify}) async {
    await _setRepeatPassword
        .call(SetRepeatPasswordParams(
            entity: _entity, repeatPassword: repeatPassword))
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

  Future<void> setEmailAddress(String emailAddress,
      {@required bool notify}) async {
    await _setEmailAddress
        .call(
            SetEmailAddressParams(entity: _entity, emailAddress: emailAddress))
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
