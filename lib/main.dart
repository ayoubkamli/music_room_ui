import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/app_navigator.dart';
import 'package:myapp/auth/auth_repository.dart';
import 'package:myapp/session_cubit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: RepositoryProvider(
            create: (context) => AuthRepository(),
            child: BlocProvider(
              create: (context) =>
                  SessionCubit(authRepo: context.read<AuthRepository>()),
              child: AppNavigator(),
            )));
  }
}
