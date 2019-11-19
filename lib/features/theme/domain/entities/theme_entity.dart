import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum ThemeType {
  Light,
  Dark,
}

String typeToString(ThemeType type) {
  return type.toString().split('.').last;
}

ThemeType stringToType(String s) {
  return ThemeType.values.firstWhere((element) => typeToString(element) == s);
}

class ThemeEntity extends Equatable {
  final ThemeType type;

  ThemeEntity({
    @required this.type,
  }) : super([type]);

  @override
  String toString() {
    return typeToString(type);
  }
}
