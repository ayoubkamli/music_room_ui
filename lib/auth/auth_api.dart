import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CreateUser {
  final String password;
  final String email;
  final Uri registerUrl = Uri.parse('http://192.168.99.100/api/auth/register');

  CreateUser(this.password, this.email);

  Future<http.Response> createUser() async {
    print('trying to create user');
    final response = await http.post(
      registerUrl,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    return response;
  }
}

class ConfirmSignUp {
  final String confirmationCode;
  final Uri consirmationUrl =
      Uri.parse('http://192.168.99.100/api/email/confirm');
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  // final SharedPreferences prefs = await _prefs;

  ConfirmSignUp(this.confirmationCode);

  Future<http.Response> confirmCode() async {
    final SharedPreferences prefs = await _prefs;
    String? token = prefs.getString('Token');
    String bearerToken = 'Bearer $token';

    final response = await http.post(
      consirmationUrl,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': '$bearerToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'code': int.parse(confirmationCode),
        },
      ),
    );
    print('Confirmation code in confirmSignUp $confirmationCode');
    return response;
  }
}
