import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';

import 'package:mall/src/core/core.dart';
import 'package:mall/src/pages/theme/theme.dart';

void main() {
  BlocSupervisor.delegate = BlocSupervisorDelegate();
  runApp(ThemePage());
}
