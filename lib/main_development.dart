import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunnah/app/app.dart';
import 'package:sunnah/common/bloc/simple_bloc_delegate.dart';
import 'package:sunnah/common/constant/env.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(App(env: EnvValue.development));
}
