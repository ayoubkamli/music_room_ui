import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/auth/utils/manage_token.dart';
import 'package:myapp/navigation/app_navigator.dart';
import 'package:myapp/auth/repositories/auth_repository.dart';
import 'package:myapp/events/logic/event_cubit.dart';
import 'package:myapp/events/repositories/event_repository.dart';
import 'package:myapp/playlists/logic/playlist_cubit.dart';
import 'package:myapp/playlists/repositories/playlist_repository.dart';

import 'package:myapp/auth/logic/session_cubit.dart';

import 'constant/constant.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoggedIn = false;

  void initState() {
    super.initState();
    _isLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthRepository(),
      child: RepositoryProvider(
        create: (context) => PlaylistRepository(),
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
              }),
              BlocProvider(create: (BuildContext newcontext) {
                return PlaylistCubit(
                  playlistRepository: newcontext.read<PlaylistRepository>(),
                );
              })
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              home: AppNavigator(),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _isLoggedIn() async {
    try {
      String? token = await MyToken().getToken();
      if (token != null) {
        print('okkkkkkk theris a token' + token.toString());
        getUserData(token);
      } else {
        print('There is no token it\'s null');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getUserData(String token) async {
    String bearerToken = 'Bearer $token';
    final response = await http.get(userDataUrl, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': '$bearerToken',
    });
    print('user data from user profile' + response.body.toString());
    print('user data from user profile' + response.statusCode.toString());
    if (response.statusCode == 200) {
      setState(() {
        isLoggedIn = true;
      });
    }
  }
}
