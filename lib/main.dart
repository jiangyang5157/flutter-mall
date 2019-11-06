import 'package:flutter/material.dart';
import 'package:mall/src/core/core.dart';
import 'package:mall/src/pages/app/app.dart';
import 'package:mall/src/utils/utils.dart';

void main() {
//  debugPaintSizeEnabled=true;
  locator.registerSingleton<Nav>(Nav());
  runApp(AppPage());
}
