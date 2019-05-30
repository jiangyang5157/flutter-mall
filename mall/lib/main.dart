import 'package:flutter/material.dart';

import 'package:mall/src.dart';

void main() => runApp(BlocProvider<ApplicationBloc>(
    bloc: ApplicationBloc(), child: ApplicationPage()));
