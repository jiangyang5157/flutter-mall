import 'package:flutter/material.dart';

import 'package:mall/src.dart';

void main() => runApp(BlocProvider<AppBloc>(
    bloc: AppBloc(), child: AppPage()));
