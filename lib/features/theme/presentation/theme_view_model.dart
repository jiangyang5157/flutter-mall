import 'package:flutter/material.dart';
import 'package:mall/core/error/failures.dart';
import 'package:mall/core/usecase/usecase.dart';
import 'package:mall/features/theme/domain/entities/theme_entity.dart';
import 'package:mall/features/theme/domain/usecases/usecases.dart' as Theme;

class ThemeViewModel extends ChangeNotifier {
  final Theme.GetLastTheme _glt;
  final Theme.SetTheme _st;

  ThemeEntity _lastTheme;

  ThemeViewModel({
    @required Theme.GetLastTheme glt,
    @required Theme.SetTheme st,
  })  : assert(glt != null),
        assert(st != null),
        _glt = glt,
        _st = st {
    print('#### ThemeViewModel - constructor');
  }

  @override
  void dispose() {
    super.dispose();
    print('#### ThemeViewModel - dispose');
  }

  ThemeEntity getLastTheme() {
    if (_lastTheme == null) {
      // returns default first
      final defaultTheme = ThemeEntity(type: ThemeType.Light);
      _lastTheme = defaultTheme;

      _glt.call(NoParams()).then((result) {
        result.fold(
          // set default if non-exist
          (failure) => setTheme(defaultTheme.type),
          (entity) {
            if (_lastTheme != entity) {
              _lastTheme = entity;

              // notify only if the value is different from the default
              notifyListeners();
            }
          },
        );
      });
    }
    return _lastTheme;
  }

  Future<Failure> setTheme(
    ThemeType type, {
    bool notify = false,
  }) async {
    Failure ret;
    await _st.call(Theme.SetThemeParams(type: type)).then((result) {
      result.fold(
        (failure) => ret = failure,
        (entity) => _lastTheme = entity,
      );
    });
    if (notify) {
      notifyListeners();
    }
    return ret;
  }
}
