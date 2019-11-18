import 'package:flutter/material.dart';
import 'package:mall/core/error/failures.dart';
import 'package:mall/core/usecase/usecase.dart';
import 'package:mall/features/theme/domain/entities/theme_entity.dart';
import 'package:mall/features/theme/domain/usecase/get_theme.dart';
import 'package:mall/features/theme/domain/usecase/save_theme.dart';

class ThemeViewModel extends ChangeNotifier {
  final GetTheme getTheme;
  final SaveTheme saveTheme;

  ThemeViewModel({
    @required GetTheme getTheme,
    @required SaveTheme saveTheme,
  })  : assert(getTheme != null),
        assert(saveTheme != null),
        getTheme = getTheme,
        saveTheme = saveTheme {
    print('#### ThemeViewModel_constructor');
  }

  @override
  void dispose() {
    super.dispose();
    print('#### ThemeViewModel_dispose');
  }

  Future<ThemeData> getThemeData(BuildContext context) async {
    final ret = await getTheme.call(NoParams());
    return ret.fold(
      (failure) => setThemeTypeWithoutNotify(context, ThemeType.Light),
      (entity) => entity.toThemeData(context),
    );
  }

  Future<ThemeData> setThemeTypeWithNotify(
      BuildContext context, ThemeType type) {
    return _setThemeType(context, type, notify: true);
  }

  Future<ThemeData> setThemeTypeWithoutNotify(
      BuildContext context, ThemeType type) {
    return _setThemeType(context, type, notify: false);
  }

  Future<ThemeData> _setThemeType(BuildContext context, ThemeType type,
      {@required bool notify}) async {
    final ret = await saveTheme.call(Params(type: type));
    if (notify) {
      notifyListeners();
    }
    return ret.fold(
      (failure) => throw CacheFailure(),
      (entity) => entity.toThemeData(context),
    );
  }
}
