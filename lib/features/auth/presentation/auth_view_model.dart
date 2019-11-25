import 'package:flutter/material.dart';
import 'package:mall/core/error/failures.dart';
import 'package:mall/core/usecase/usecase.dart';
import 'package:mall/features/auth/domain/entities/auth_entity.dart';
import 'package:mall/features/auth/domain/usecases/usecases.dart' as Auth;

class AuthViewModel extends ChangeNotifier {
  final Auth.GetData _getData;
  final Auth.SetData _setData;

  AuthEntity _currentEntity;

  AuthViewModel({
    @required Auth.GetData getData,
    @required Auth.SetData setData,
  })  : assert(getData != null),
        assert(setData != null),
        _getData = getData,
        _setData = setData {
    print('#### AuthViewModel - constructor');
  }

  @override
  void dispose() {
    super.dispose();
    print('#### AuthViewModel - dispose');
  }

  AuthEntity getCurrentData() {
    if (_currentEntity == null) {
      // returns default first
      final defaultEntity = AuthEntity(state: AuthState.SignIn);
      _currentEntity = defaultEntity;

      _getData.call(NoParams()).then((result) {
        result.fold(
          // set default if non-exist
          (failure) => setCurrentData(defaultEntity.state),
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
    AuthState state, {
    bool notify = false,
  }) async {
    Failure ret;
    await _setData.call(Auth.SetDataParams(state: state)).then((result) {
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
