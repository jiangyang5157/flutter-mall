import 'package:flutter/material.dart';
import 'package:mall/core/error/failures.dart';
import 'package:mall/features/theme/domain/entities/theme_entity.dart';
import 'package:mall/features/theme/domain/usecases/usecases.dart' as Theme;

class ThemeViewModel extends ChangeNotifier {
  final Theme.GetLastTheme _glt;
  final Theme.SetTheme _st;

  final _defaultTheme = ThemeEntity(type: ThemeType.Light);
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
      _lastTheme = _defaultTheme;
      fetchLastTheme(notify: true);
    }
    return _lastTheme;
  }

  Future<void> fetchLastTheme({bool notify = false}) async {
    Failure ret;
    await _glt.call(Theme.GetLastThemeParams()).then((result) {
      result.fold(
        (failure) => setTheme(_defaultTheme.type),
        (entity) => _lastTheme = entity,
      );
    });
    if (notify) {
      notifyListeners();
    }
    return ret;
  }

  Future<Failure> setTheme(
    ThemeType type, {
    bool notify = false,
  }) async {
    Failure ret;
    await _st.call(Theme.SetThemeParams(type)).then((result) {
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
