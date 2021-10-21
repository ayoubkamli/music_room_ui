import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:myapp/auth/repositories/auth_repository.dart';
import 'package:myapp/events/logic/event_cubit.dart';
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
  /// late String isLoggedIn = '';

  void initState() {
    super.initState();

    /// _isLoggedIn().then((value) => setState(() {
    ///       isLoggedIn = value;
    ///       print(isLoggedIn);
    ///     }));
  }

  @override
  Widget build(BuildContext context) {
    /// print('Widget build' + isLoggedIn.toString());
    return MaterialApp(debugShowCheckedModeBanner: false, home: _body());
  }

  /// Future<String> _isLoggedIn() async {
  ///   try {
  ///     String? token = await MyToken().getToken();

  ///     if (token != null) {
  ///       print('okkkkkkk theris a token' + token.toString());
  ///       print('1');
  ///       return await getUserData(token);
  ///     } else {
  ///       print('There is no token it\'s null');
  ///       return Future<String>.value('null');
  ///     }
  ///   } catch (e) {
  ///     print(e);
  ///     return Future<String>.value('null');
  ///   }
  /// }

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
          })
        ],
        child: AppNavigator(),
      ),
    );
  }

  /// Future<String> getUserData(String token) async {
  ///   String bearerToken = 'Bearer $token';
  ///   final response = await http.get(userDataUrl, headers: <String, String>{
  ///     'Content-Type': 'application/json; charset=UTF-8',
  ///     'Authorization': '$bearerToken',
  ///   });
  ///   print('user data from user profile ' + response.body.toString());
  ///   print('user response from user profile ' + response.statusCode.toString());
  ///   if (response.statusCode == 200) {
  ///     print('200');
  ///     return 'loggedIn';
  ///   } else {
  ///     print('400');
  ///     return 'invalide';
  ///   }
  /// }
}
