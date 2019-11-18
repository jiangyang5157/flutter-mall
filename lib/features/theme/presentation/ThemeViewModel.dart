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
    print('#### 1111');
    if (_model == null) {
      print('#### 2222');
      _model = ThemeModel(type: ThemeType.Light);

      _getTheme.call(NoParams()).then((result) {
        result.fold(
          (failure) {
            print('#### 3333');
            setTheme(ThemeType.Light, notify: false);
          },
          (entity) {
            print('#### 4444');
            if (_model != entity) {
              print('#### 5555');
              _model = entity;
              notifyListeners();
              print('#### 6666');
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
