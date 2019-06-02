import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';

import 'package:mall/src/core/core.dart';
import 'package:mall/src/pages/theme_app/theme_app.dart';

void main() {
  BlocSupervisor.delegate = BlocSupervisorDelegate();
  runApp(ThemeAppPage());
}
