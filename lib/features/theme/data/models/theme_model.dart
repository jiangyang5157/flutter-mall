import 'package:flutter/material.dart';
import 'package:mall/features/theme/domain/entities/theme_entity.dart';

class ThemeModel extends ThemeEntity {
  ThemeModel({
    @required ThemeType type,
  }) : super(type: type);

  factory ThemeModel.fromString(String s) {
    return ThemeModel(type: stringToType(s));
  }
}
