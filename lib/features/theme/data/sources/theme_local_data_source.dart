import 'package:flutter/material.dart';
import 'package:mall/core/error/exceptions.dart';
import 'package:mall/features/theme/domain/entities/theme_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ThemeLocalDataSource {
  /// Throws [CacheException] if no cached data is present.
  Future<ThemeEntity> getLastTheme({bool fromMemory = true});

  /// Throws [CacheException]
  Future<ThemeEntity> setTheme(ThemeEntity entity);
}

const _prefs_theme = 'key_prefs_theme';

class ThemeLocalDataSourceImpl implements ThemeLocalDataSource {
  final SharedPreferences prefs;
  ThemeEntity entity;

  ThemeLocalDataSourceImpl({@required this.prefs});

  @override
  Future<ThemeEntity> setTheme(ThemeEntity theme) async {
    if (await prefs.setString(_prefs_theme, theme.toString())) {
      entity = theme;
    } else {
      throw CacheException();
    }
    return entity;
  }

  @override
  Future<ThemeEntity> getLastTheme({bool fromMemory = true}) async {
    if (entity == null || !fromMemory) {
      final s = prefs.getString(_prefs_theme);
      if (s == null) {
        throw CacheException();
      } else {
        entity = ThemeEntity.fromString(s);
      }
    }
    return entity;
  }
}
