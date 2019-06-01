import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';

import 'package:mall/src/core/core.dart';
import 'package:mall/src/pages/app/app.dart';

void main() {
  BlocSupervisor.delegate = BlocSupervisorDelegate();
  runApp(AppPage());
}
