import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:myapp/auth/repositories/auth_repository.dart';
import 'package:myapp/events/logic/event_cubit.dart';
import 'package:myapp/events/logic/my_event_cubit.dart';
import 'package:myapp/events/repositories/event_repository.dart';
import 'package:myapp/navigation/app_navigator.dart';
import 'package:myapp/playlists/logic/playlist_cubit.dart';
import 'package:myapp/playlists/repositories/playlist_repository.dart';

import 'package:myapp/auth/logic/session_cubit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: _body());
  }

  _body() {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => EventRepository()),
        RepositoryProvider(create: (context) => AuthRepository()),
        RepositoryProvider(
          create: (context) => PlaylistRepository(),
        ),
      ],
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
          }),
          BlocProvider(create: (BuildContext newcontext) {
            return PlaylistCubit(
              playlistRepository: newcontext.read<PlaylistRepository>(),
            );
          }),
          BlocProvider(create: (BuildContext newcontext) {
            return MyEventCubit(
              eventRepository: newcontext.read<EventRepository>(),
            );
          })
        ],
        child: AppNavigator(),
      ),
    );
  }
}
