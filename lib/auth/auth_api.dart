import 'dart:convert';

import 'package:http/http.dart' as http;

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
