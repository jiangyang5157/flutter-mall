import 'package:flutter/material.dart';
import 'package:mall/core/error/exceptions.dart';
import 'package:mall/features/theme/data/models/theme_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ThemeLocalDataSource {
  /// Throws [CacheException] if no cached data is present.
  Future<ThemeModel> getLastData();

  Future<bool> cacheData(ThemeModel model);
}

const _prefs_theme = 'key_prefs_theme';

class ThemeLocalDataSourceImpl implements ThemeLocalDataSource {
  final SharedPreferences prefs;

  ThemeLocalDataSourceImpl({@required this.prefs});

  @override
  Future<bool> cacheData(ThemeModel theme) async {
    return await prefs.setString(_prefs_theme, theme.toString());
  }

  @override
  Future<ThemeModel> getLastData() async {
    final themeString = prefs.getString(_prefs_theme);
    if (themeString == null) {
      throw CacheException();
    }
    return ThemeModel.fromString(themeString);
  }
}
