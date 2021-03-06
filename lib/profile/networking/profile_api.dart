import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:myapp/auth/utils/manage_token.dart';
import 'package:myapp/constant/constant.dart';

class EditProfile {
  // final String email;
  // final String username;
  // final List<String> prefs;

  EditProfile();

  Future<http.Response> editProfileForm(
      String username, String email, List<String> prefs) async {
    String? token = await MyToken().getToken();
    String bearerToken = 'Bearer $token';

    final response = await http.put(editProfileUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': '$bearerToken',
        },
        body: jsonEncode(<String, dynamic>{
          "email": '$email',
          "username": "$username",
          "musicPreference": prefs,
        }));
    return response;
  }

  Future<http.Response> changePassword(
      String oldPassword, String newPassword) async {
    String? token = await MyToken().getToken();
    String bearerToken = 'Bearer $token';

    final response = await http.put(changePasswordUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': '$bearerToken',
        },
        body: jsonEncode(<String, dynamic>{
          "oldPassword": '$oldPassword',
          "newPassword": "$newPassword",
        }));
    return response;
  }
}
