import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/app_navigator.dart';
import 'package:myapp/auth/auth_repository.dart';
import 'package:myapp/event/event_cubit.dart';
import 'package:myapp/event/event_repository.dart';

import 'package:myapp/session_cubit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthRepository(),
      child: RepositoryProvider(
        create: (context) => EventRepository(),
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) =>
                  SessionCubit(authRepo: context.read<AuthRepository>()),
            ),
            BlocProvider(create: (BuildContext context) {
              return EventCubit(
                eventRepository: context.read<EventRepository>(),
              );
            })
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: AppNavigator(),
          ),
        ),
      ),
    );
  }
}
