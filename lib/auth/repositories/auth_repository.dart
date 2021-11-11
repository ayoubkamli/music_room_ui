import 'package:flutter/material.dart';
import 'package:myapp/auth/networking/auth_api.dart';

import 'package:http/http.dart' as http;
import 'package:myapp/auth/screens/login_view.dart';
import 'package:myapp/constant/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  Future<String> attemptAutoLogin() async {
    print('attempAuthoLogin was called');
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    SharedPreferences prefs = await _prefs;
    final String? token = prefs.getString("Token").toString();
    print('attempAuthoLogin token ' + token!.toString());

    String bearerToken = 'Bearer $token';

    print('Authorization ' + bearerToken);
    try {
      final response = await http.get(userDataUrl, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': '$bearerToken',
      });
      print('user data from user profile ' + response.body.toString());
      print(
          'user response from user profile ' + response.statusCode.toString());
      if (response.statusCode == 200) {
        print('200');
        return 'loggedIn';
      } else {
        print('400');
        return 'invalide';
      }
    } catch (e) {
      print('errrrorororororor');
    }
    return 'Invalid';
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

    return response;
  }

  Future<http.Response> resetForgotPassword(
      {String? confirmationCode, String? newPassword}) async {
    print('this is confirmation code: $confirmationCode +  $newPassword');
    final response = ForgotPasswordReset(confirmationCode!, newPassword!)
        .resetForgotPassword();

    return response;
  }

  Future<http.Response> forgotPassword(String email) async {
    final response = ForgotPassword(email).sendCode();
    return response;
  }

  Future<void> signOut() async {
    await LogOut().logoutUser();
    MaterialPageRoute(builder: (_) => LoginView());
  }
}
