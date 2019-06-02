import 'package:flutter/material.dart';

void runOnWidgetDidBuild(Function func) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    func();
  });
}
