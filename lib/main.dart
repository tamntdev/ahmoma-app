import 'package:ahmoma_app/modules/app/cubit/my_app_cubit.dart';
import 'package:ahmoma_app/modules/app/my_app.dart';
import 'package:ahmoma_app/modules/network/network_manager_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => MyAppCubit()),
        BlocProvider(create: (context) => NetworkManagerCubit()),
      ],
      child: const MyApp(),
    ),
  );
}
