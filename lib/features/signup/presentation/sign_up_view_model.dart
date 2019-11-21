import 'package:flutter/material.dart';
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

  SignUpEntity _entity;

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
    if (_entity == null) {
      // returns default first
      final defaultEntity = SignUpEntity(
        username: '',
        password: '',
        repeatPassword: '',
        emailAddress: '',
        obscurePassword: true,
      );
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
              notify: false,
            );
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
        .call(SignUp.SetDataParams(
            username: username,
            password: password,
            repeatPassword: repeatPassword,
            emailAddress: emailAddress,
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
        .call(SignUp.SetUsernameParams(entity: _entity, username: username))
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
        .call(SignUp.SetPasswordParams(entity: _entity, password: password))
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

  Future<void> setRepeatPassword(String repeatPassword,
      {@required bool notify}) async {
    await _setRepeatPassword
        .call(SignUp.SetRepeatPasswordParams(
            entity: _entity, repeatPassword: repeatPassword))
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

  Future<void> setEmailAddress(String emailAddress,
      {@required bool notify}) async {
    await _setEmailAddress
        .call(SignUp.SetEmailAddressParams(
            entity: _entity, emailAddress: emailAddress))
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
        .call(SignUp.SetObscurePasswordParams(
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
