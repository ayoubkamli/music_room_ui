import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/auth/repositories/auth_credentials.dart';
import 'package:myapp/auth/repositories/auth_repository.dart';
import 'package:myapp/auth/logic/session_state.dart';
import 'package:myapp/auth/screens/login_view.dart';
import 'package:myapp/auth/utils/manage_token.dart';
import 'package:myapp/constant/constant.dart';

class SessionCubit extends Cubit<SessionState> {
  final AuthRepository authRepo;

  SessionCubit({required this.authRepo}) : super(UnknownSessionState()) {
    attemptAutoLogin();
  }

  void attemptAutoLogin() async {
    try {
      final response = await authRepo.attemptAutoLogin();
      //final user = dataRepo.getUser(userId);
      print('attemp auth from session_cubit' + response);
      if (response == 'loggedIn') {
        final String? token = MyToken().getToken().toString();
        String bearerToken = 'Bearer $token';
        final user = await http.get(userDataUrl, headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': '$bearerToken',
        });
        print('user data from user profile ' + user.body.toString());
        print('user response from user profile ' + user.statusCode.toString());
        emit(Authenticated(jsonDecode(user.body).toString()));
      } else {
        emit(Unauthenticated());
      }
    } on Exception {
      emit(Unauthenticated());
    }
  }

  void showAuth() => emit(Unauthenticated());
  void showSession(AuthCredentials credentials) {
    // final user = dataRepo.getUser(credentials.userId);
    final user = credentials.username;
    emit(Authenticated(user));
  }

  void signOut() {
    authRepo.signOut();
    emit(Unauthenticated());
    print('signout from session cubit was called');
    MaterialPageRoute(builder: (_) => LoginView());
  }
}
