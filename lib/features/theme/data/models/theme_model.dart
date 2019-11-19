import 'package:flutter/material.dart';
import 'package:mall/constant.dart';
import 'package:mall/features/theme/domain/entities/theme_entity.dart';

class ThemeModel extends ThemeEntity {
  ThemeModel({
    @required ThemeType type,
  }) : super(type: type);

  factory ThemeModel.fromString(String s) {
    return ThemeModel(type: stringToType(s));
  }

  ThemeData toThemeData(BuildContext context) {
    switch (type) {
      case ThemeType.Dark:
        return ThemeData.dark().copyWith(
          primaryColor: Colors.green,
          accentColor: Colors.greenAccent,
          errorColor: Colors.greenAccent,
          buttonTheme: ButtonTheme.of(context).copyWith(
            textTheme: ButtonTextTheme.primary,
            buttonColor: Colors.green,
            minWidth: btnMinWidth,
            height: btnHeight,
          ),
        );
      case ThemeType.Light:
        return ThemeData.light().copyWith(
          primaryColor: Colors.blue,
          accentColor: Colors.blueAccent,
          errorColor: Colors.blueAccent,
          buttonTheme: ButtonTheme.of(context).copyWith(
            textTheme: ButtonTextTheme.primary,
            buttonColor: Colors.blue,
            minWidth: btnMinWidth,
            height: btnHeight,
          ),
        );
      default:
        throw ("ThemeType ${typeToString(type)} is not supported.");
        break;
    }
  }
}
