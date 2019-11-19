import 'package:flutter/material.dart';
import 'package:mall/core/error/exceptions.dart';
import 'package:mall/features/theme/domain/entities/theme_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ThemeLocalDataSource {
  /// Throws [CacheException] if no cached data is present.
  Future<ThemeEntity> getLastTheme();

  Future<bool> cacheTheme(ThemeEntity entity);
}

const _prefs_theme = 'key_prefs_theme';

class ThemeLocalDataSourceImpl implements ThemeLocalDataSource {
  final SharedPreferences prefs;

  ThemeLocalDataSourceImpl({@required this.prefs});

  @override
  Future<bool> cacheTheme(ThemeEntity theme) async {
    return await prefs.setString(_prefs_theme, theme.toString());
  }

  @override
  Future<ThemeEntity> getLastTheme() async {
    final s = prefs.getString(_prefs_theme);
    if (s == null) {
      throw CacheException();
    }
    return ThemeEntity.fromString(s);
  }
}
