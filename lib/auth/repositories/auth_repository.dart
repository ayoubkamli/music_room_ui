import 'package:flutter/material.dart';
import 'package:myapp/auth/networking/auth_api.dart';

import 'package:http/http.dart' as http;
import 'package:myapp/auth/screens/login_view.dart';

class AuthRepository {
  Future<String> attemptAutoLogin() async {
    await Future.delayed(Duration(seconds: 2));
    throw Exception('not signed in');
  }

  Future<http.Response> login(
    String email,
    String password,
  ) async {
    final response = LoginUser(password, email).loginUser();
    return response;
  }

  Future<http.Response> signUp(
    String email,
    String password,
  ) async {
    final response = CreateUser(password, email).createUser();

    return response;
  }

  Future<http.Response> confirmationSignUp({
    String? confirmationCode,
  }) async {
    print('this is confirmation code: $confirmationCode');
    final response = ConfirmSignUp(confirmationCode!).confirmCode();

    ////todo bloc confirmation logic
    return response;
  }

  Future<void> signOut() async {
    await LogOut().logoutUser();
    MaterialPageRoute(builder: (_) => LoginView());
  }
}
