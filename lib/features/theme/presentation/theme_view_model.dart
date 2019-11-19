import 'package:flutter/material.dart';
import 'package:mall/core/usecase/usecase.dart';
import 'package:mall/features/theme/domain/entities/theme_entity.dart';
import 'package:mall/features/theme/domain/usecases/usecases.dart' as Theme;

class ThemeViewModel extends ChangeNotifier {
  final Theme.GetData _getData;
  final Theme.SetData _setData;

  ThemeEntity _entity;

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

  ThemeEntity getCurrentTheme() {
    if (_entity == null) {
      // returns default first
      final defaultEntity = ThemeEntity(type: ThemeType.Light);
      _entity = defaultEntity;

      _getData.call(NoParams()).then((result) {
        result.fold(
          (failure) {
            // set default if non-exist
            setCurrentTheme(defaultEntity.type, notify: false);
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

  Future<void> setCurrentTheme(ThemeType type, {@required bool notify}) async {
    await _setData.call(Theme.SetDataParams(type: type)).then((result) {
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
