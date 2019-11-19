import 'package:flutter/material.dart';
import 'package:mall/core/error/failures.dart';
import 'package:mall/core/usecase/usecase.dart';
import 'package:mall/features/signup/domain/entities/sign_up_entity.dart';
import 'package:mall/features/signup/domain/usecases/get_sign_up_data.dart';
import 'package:mall/features/signup/domain/usecases/set_email_address.dart';
import 'package:mall/features/signup/domain/usecases/set_obscure_password.dart';
import 'package:mall/features/signup/domain/usecases/set_password.dart';
import 'package:mall/features/signup/domain/usecases/set_repeat_password.dart';
import 'package:mall/features/signup/domain/usecases/set_sign_up_data.dart';
import 'package:mall/features/signup/domain/usecases/set_username.dart';

class SignUpViewModel extends ChangeNotifier {
  final GetSignUpData _getSignUpData;
  final SetSignUpData _setSignUpData;
  final SetUsername _setUsername;
  final SetPassword _setPassword;
  final SetRepeatPassword _setRepeatPassword;
  final SetEmailAddress _setEmailAddress;
  final SetObscurePassword _setObscurePassword;

  SignUpEntity _entity;

  SignUpViewModel({
    @required GetSignUpData getSignUpData,
    @required SetSignUpData setSignUpData,
    @required SetUsername setUsername,
    @required SetPassword setPassword,
    @required SetRepeatPassword setRepeatPassword,
    @required SetEmailAddress setEmailAddress,
    @required SetObscurePassword setObscurePassword,
  })  : assert(getSignUpData != null),
        assert(setSignUpData != null),
        assert(setUsername != null),
        assert(setPassword != null),
        assert(setRepeatPassword != null),
        assert(setEmailAddress != null),
        assert(setObscurePassword != null),
        _getSignUpData = getSignUpData,
        _setSignUpData = setSignUpData,
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

  SignUpEntity getCurrentSignUpData() {
    if (_entity == null) {
      // returns default first
      _entity = SignUpEntity(
          username: '',
          password: '',
          repeatPassword: '',
          emailAddress: '',
          obscurePassword: true);

      _getSignUpData.call(NoParams()).then((result) {
        result.fold(
          (failure) {
            // set default if non-exist
            setCurrentSignUpData('', '', '', '', true, notify: false);
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

  Future<void> setCurrentSignUpData(String username, String password,
      String repeatPassword, String emailAddress, bool obscurePassword,
      {@required bool notify}) async {
    await _setSignUpData
        .call(Params(
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
}
