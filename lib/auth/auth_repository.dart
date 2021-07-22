import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AuthRepository {
  Future<String> attemptAutoLogin() async {
    await Future.delayed(Duration(seconds: 2));
    throw Exception('not signed in');
  }

  Future<String> login(
    String username,
    String password,
  ) async {
    print('attemping login');
    await Future.delayed(Duration(seconds: 3));
    return 'abc';
  }

  Future<http.Response> signUp(
    String username,
    String email,
    String password,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.post(
      Uri.parse('http://192.168.1.107:4004/api/auth/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 201) {
      Map<String, dynamic> data = jsonDecode(response.body);
      String token = data['data']['mailConfToken'];
      prefs.setString('Token', token);

      print('Token is => ${data["data"]["mailConfToken"]}');

      print('confirmation code is ${data["data"]["mailConfCode"]}');
    } else {
      print(Exception(response.body));
    }
    return response;
  }

  Future<http.Response> confirmationSignUp({
    String? confirmationCode,
  }) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

    final SharedPreferences prefs = await _prefs;

    String? token = prefs.getString('Token');
    String bearerToken = 'Bearer $token';

    final response = await http.post(
        Uri.parse('http://192.168.1.107:4004/api/email/confirm'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': '$bearerToken',
        },
        body: jsonEncode(<String, dynamic>{
          'code': confirmationCode,
        }));
    print('this is the conformation code $confirmationCode');
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      String token = data['data']['token'];
      prefs.setString('Token', token);
    }
    print(response.body);
    return response;
  }

  Future<void> signOut() async {
    await Future.delayed(Duration(seconds: 2));
  }
}
