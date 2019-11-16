import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mall/pages/app/app_page.dart';
import 'package:provider/provider.dart';
import 'package:mall/injection.dart' as di;

void main() async {
//  debugPaintSizeEnabled = true;
  Provider.debugCheckInvalidValueType = null;

  await di.init();
  runApp(AppPage());
}
