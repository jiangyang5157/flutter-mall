import 'package:flutter/material.dart';
import 'package:mall/core/usecase/usecase.dart';
import 'package:mall/features/auth/domain/entities/auth_entity.dart';
import 'package:mall/features/auth/domain/usecases/usecases.dart' as Auth;

class AuthViewModel extends ChangeNotifier {
  final Auth.GetData _getData;
  final Auth.SetData _setData;

  AuthEntity _entity;

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
    if (_entity == null) {
      // returns default first
      final defaultEntity = AuthEntity(state: AuthState.SignIn);
      _entity = defaultEntity;

      _getData.call(NoParams()).then((result) {
        result.fold(
          (failure) {
            // set default if non-exist
            setCurrentData(defaultEntity.state, notify: false);
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

  Future<void> setCurrentData(AuthState state, {@required bool notify}) async {
    await _setData.call(Auth.SetDataParams(state: state)).then((result) {
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
