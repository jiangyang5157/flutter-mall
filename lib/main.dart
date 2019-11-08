import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mall/src/core/core.dart';
import 'package:mall/src/pages/app/app.dart';
import 'package:mall/src/utils/utils.dart';
import 'package:provider/provider.dart';

void main() {
//  debugPaintSizeEnabled = true;
  Provider.debugCheckInvalidValueType = null;
  locator.registerSingleton<Nav>(Nav());
  runApp(AppPage());
}
