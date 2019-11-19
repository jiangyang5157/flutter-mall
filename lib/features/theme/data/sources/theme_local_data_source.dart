import 'package:flutter/material.dart';
import 'package:mall/core/error/exceptions.dart';
import 'package:mall/features/theme/domain/entities/theme_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ThemeLocalDataSource {
  /// Throws [CacheException] if no cached data is present.
  Future<ThemeEntity> getLastTheme();

  /// Throws [CacheException] if failed to cache the data.
  Future<void> cacheTheme(ThemeEntity entity);
}

const _prefs_theme = 'key_prefs_theme';

class ThemeLocalDataSourceImpl implements ThemeLocalDataSource {
  final SharedPreferences prefs;

  ThemeLocalDataSourceImpl({@required this.prefs});

  @override
  Future<void> cacheTheme(ThemeEntity theme) async {
    final result = await prefs.setString(_prefs_theme, theme.toString());
    if (!result) {
      throw CacheException();
    }
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
