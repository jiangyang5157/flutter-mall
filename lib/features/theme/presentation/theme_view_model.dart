import 'package:flutter/material.dart';
import 'package:mall/core/error/failures.dart';
import 'package:mall/core/usecase/usecase.dart';
import 'package:mall/features/theme/domain/entities/theme_entity.dart';
import 'package:mall/features/theme/domain/usecases/get_theme.dart';
import 'package:mall/features/theme/domain/usecases/set_theme.dart';

class ThemeViewModel extends ChangeNotifier {
  final GetTheme _getTheme;
  final SetTheme _setTheme;

  ThemeEntity _entity;

  ThemeViewModel({
    @required GetTheme getTheme,
    @required SetTheme setTheme,
  })  : assert(getTheme != null),
        assert(setTheme != null),
        _getTheme = getTheme,
        _setTheme = setTheme {
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

      _getTheme.call(NoParams()).then((result) {
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
    await _setTheme.call(SetThemeParams(type: type)).then((result) {
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
