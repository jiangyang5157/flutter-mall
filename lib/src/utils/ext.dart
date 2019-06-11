import 'package:flutter/material.dart';

import 'package:mall/src/core/core.dart';

String string(BuildContext context, String id) =>
    Localization.of(context).string(id) ?? null;

void runOnWidgetDidBuild(Function func) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    func();
  });
}
