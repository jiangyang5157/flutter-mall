import 'package:flutter/material.dart';
import 'src.dart';

void main() => runApp(BlocProvider<AppBloc>(
    bloc: AppBloc(), child: AppPage()));
