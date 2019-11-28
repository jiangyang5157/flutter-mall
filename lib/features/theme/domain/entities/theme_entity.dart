import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mall/core/constant.dart';

enum ThemeType {
  Light,
  Dark,
}

String typeToString(ThemeType type) {
  return type.toString().split('.').last;
}

ThemeType stringToType(String s) {
  try {
    return ThemeType.values.firstWhere((element) => typeToString(element) == s);
  } on StateError {
    return null;
  }
}

class ThemeEntity extends Equatable {
  final ThemeType type;

  ThemeEntity({
    @required this.type,
  }) : super([type]);

  factory ThemeEntity.fromString(String s) {
    return ThemeEntity(type: stringToType(s));
  }

  @override
  String toString() {
    return typeToString(type);
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
