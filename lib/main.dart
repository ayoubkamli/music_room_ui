import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:myapp/auth/repositories/auth_repository.dart';
import 'package:myapp/events/repositories/event_repository.dart';
import 'package:myapp/navigation/app_navigator.dart';
import 'package:myapp/playlists/all_playlist/all_playlist_cubit.dart';
import 'package:myapp/playlists/my_playlist/my_playlist_cubit.dart';
import 'package:myapp/playlists/repositories/playlist_repository.dart';

import 'package:myapp/auth/session_cubit.dart';
import 'package:myapp/profile/bloc/edit_profile_bloc.dart';
import 'package:myapp/profile/repository/profile_repository.dart';
import 'package:myapp/search/bloc/search_bloc.dart';
import 'package:myapp/search/bloc/search_repository.dart';

import 'events/bloc/all_event/event_cubit.dart';
import 'events/bloc/my_event/my_event_cubit.dart';

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
        RepositoryProvider(create: (context) => SearchRepositoryTracks()),
        RepositoryProvider(create: (context) => ProfileRepository()),
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
          BlocProvider(create: (BuildContext context) {
            return AllPlaylistCubit(
              playlistRepository: context.read<PlaylistRepository>(),
            );
          }),
          BlocProvider(create: (BuildContext context) {
            return MyPlaylistCubit(
              playlistRepository: context.read<PlaylistRepository>(),
            );
          }),
          BlocProvider(create: (BuildContext newcontext) {
            return MyEventCubit(
              eventRepository: newcontext.read<EventRepository>(),
            );
          }),
          BlocProvider(create: (BuildContext newContext) {
            return SearchBloc(
              searchRepository: newContext.read<SearchRepositoryTracks>(),
            );
          }),
          BlocProvider(create: (BuildContext newContext) {
            return EditProfileBloc(
              profileRepository: newContext.read<ProfileRepository>(),
            );
          })
        ],
        child: AppNavigator(),
      ),
    );
  }
}
