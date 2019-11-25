import 'package:flutter/material.dart';
import 'package:mall/core/error/failures.dart';
import 'package:mall/core/usecase/usecase.dart';
import 'package:mall/features/theme/domain/entities/theme_entity.dart';
import 'package:mall/features/theme/domain/usecases/usecases.dart' as Theme;

class ThemeViewModel extends ChangeNotifier {
  final Theme.GetData _getData;
  final Theme.SetData _setData;

  ThemeEntity _currentEntity;

  ThemeViewModel({
    @required Theme.GetData getData,
    @required Theme.SetData setData,
  })  : assert(getData != null),
        assert(setData != null),
        _getData = getData,
        _setData = setData {
    print('#### ThemeViewModel - constructor');
  }

  @override
  void dispose() {
    super.dispose();
    print('#### ThemeViewModel - dispose');
  }

  ThemeEntity getCurrentData() {
    if (_currentEntity == null) {
      // returns default first
      final defaultEntity = ThemeEntity(type: ThemeType.Light);
      _currentEntity = defaultEntity;

      _getData.call(NoParams()).then((result) {
        result.fold(
          // set default if non-exist
          (failure) => setCurrentData(defaultEntity.type),
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
    ThemeType type, {
    bool notify = false,
  }) async {
    Failure ret;
    await _setData.call(Theme.SetDataParams(type: type)).then((result) {
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
