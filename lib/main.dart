import 'package:flutter/material.dart';

import 'package:mall/src/pages/app/app.dart';
import 'package:mall/src/core/core.dart';

void main() {
  locator.registerSingleton<Nav>(Nav());
  runApp(AppPage());
}
