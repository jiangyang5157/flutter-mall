import 'package:flutter/material.dart';
import 'package:mall/core/error/failures.dart';
import 'package:mall/core/usecase/usecase.dart';
import 'package:mall/features/theme/data/models/theme_model.dart';
import 'package:mall/features/theme/domain/entities/theme_entity.dart';
import 'package:mall/features/theme/domain/usecase/get_theme.dart';
import 'package:mall/features/theme/domain/usecase/save_theme.dart';

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
      _model = ThemeModel(type: ThemeType.Light);

      _getTheme.call(NoParams()).then((result) {
        result.fold(
          (failure) {
            setTheme(ThemeType.Light, notify: false);
          },
          (entity) {
            if (_model != entity) {
              _model = entity;
              notifyListeners();
            }
          },
        );
      });
    }
    return _model;
  }

  Future<void> setTheme(ThemeType type, {@required bool notify}) async {
    final ret = await _saveTheme.call(Params(type: type));
    _model = ret.fold(
      (failure) => throw CacheFailure(),
      (entity) => entity,
    );
    if (notify) {
      notifyListeners();
    }
  }
}
