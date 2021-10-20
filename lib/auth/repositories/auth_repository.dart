import 'package:flutter/material.dart';
import 'package:myapp/auth/networking/auth_api.dart';

import 'package:http/http.dart' as http;
import 'package:myapp/auth/screens/login_view.dart';
import 'package:myapp/auth/utils/manage_token.dart';
import 'package:myapp/constant/constant.dart';

class AuthRepository {
  Future<String> attemptAutoLogin() async {
    final String? token = MyToken().getToken();
    final http.Response? response;
    if (token != null) {
      String bearerToken = 'Bearer $token';
      response = await http.get(userDataUrl, headers: <String, String>{
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
    }
    return 'unauthenticated';
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
