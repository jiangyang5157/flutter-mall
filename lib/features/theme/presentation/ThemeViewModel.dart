import 'package:flutter/material.dart';
import 'package:mall/core/error/failures.dart';
import 'package:mall/core/usecase/usecase.dart';
import 'package:mall/features/theme/data/models/theme_model.dart';
import 'package:mall/features/theme/domain/entities/theme_entity.dart';
import 'package:mall/features/theme/domain/usecases/get_theme.dart';
import 'package:mall/features/theme/domain/usecases/save_theme.dart';

class ThemeViewModel extends ChangeNotifier {
  final GetTheme _getTheme;
  final SaveTheme _saveTheme;

  ThemeModel _model;

  ThemeViewModel({
    @required GetTheme getTheme,
    @required SaveTheme saveTheme,
  })  : assert(getTheme != null),
        assert(saveTheme != null),
        _getTheme = getTheme,
        _saveTheme = saveTheme {
    print('#### ThemeViewModel - constructor');
  }

  @override
  void dispose() {
    super.dispose();
    print('#### ThemeViewModel - dispose');
  }

  ThemeModel getTheme() {
    if (_model == null) {
      // returns default first
      _model = ThemeModel(type: ThemeType.Light);

      _getTheme.call(NoParams()).then((result) {
        result.fold(
          (failure) {
            // set default if non-exist
            setTheme(ThemeType.Light, notify: false);
          },
          (entity) {
            if (_model != entity) {
              _model = entity;

              // notify only if the value is different from the default
              notifyListeners();
            }
          },
        );
      });
    }
    return _model;
  }

  Future<void> setTheme(ThemeType type, {@required bool notify}) async {
    await _saveTheme.call(Params(type: type)).then((result) {
      _model = result.fold(
        (failure) => throw CacheFailure(),
        (entity) => entity,
      );
    });
    if (notify) {
      notifyListeners();
    }
  }
}
