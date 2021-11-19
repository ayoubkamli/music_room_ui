import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:myapp/auth/utils/manage_token.dart';
import 'package:myapp/constant/constant.dart';

/// import 'package:shared_preferences/shared_preferences.dart';

class CreateUser {
  final String password;
  final String email;

  CreateUser(this.password, this.email);

  Future<http.Response> createUser() async {
    // print('trying to create user');
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

  /// Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  // final SharedPreferences prefs = await _prefs;

  ConfirmSignUp(this.confirmationCode);

  Future<http.Response> confirmCode() async {
    /// final SharedPreferences prefs = await _prefs;
    /// String? token = prefs.getString('Token');
    String? token = await MyToken().getToken();
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

class ForgotPasswordReset {
  final String confirmationCode;
  final String newPassword;

  /// Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  // final SharedPreferences prefs = await _prefs;

  ForgotPasswordReset(this.confirmationCode, this.newPassword);

  Future<http.Response> resetForgotPassword() async {
    // print('\n 8888888888888888 resetForgotPassword 8888888888888 \n ');
    // String? token = await MyToken().getToken();
    // String bearerToken = 'Bearer $token';

    final response = await http.put(
      forgotPasswordResetUrl,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        // 'Authorization': '$bearerToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'code': int.parse(confirmationCode),
          'password': '$newPassword'
        },
      ),
    );
    // print(
    //     'Confirmation code in confirmSignUp $confirmationCode , $newPassword');
    // print(
    //     '\n 8888888888888888 auth api Forgot password response body 8888888888888 \n ');
    // print(response.body.toString());
    return response;
  }
}

class LoginUser {
  final String password;
  final String email;

  LoginUser(this.password, this.email);

  Future<http.Response> loginUser() async {
    // print('trying to login user $email - $password');
    final response = await http.post(
      loginUrl,
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

class ForgotPassword {
  final String email;

  ForgotPassword(this.email);

  Future<http.Response> sendCode() async {
    // print('trying to forgot password user $email');
    final response = await http.post(
      forgotPasswordUrl,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
      }),
    );

    return response;
  }
}

class LogOut {
  /// Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> logoutUser() async {
    /// final SharedPreferences prefs = await _prefs;
    /// String? token = prefs.getString('Token');
    String? token = await MyToken().getToken();
    String bearerToken = 'Bearer $token';
    // print('logout function in api called');
    final response = await http.post(
      logoutUrl,
      headers: <String, String>{
        'Authorization': '$bearerToken',
      },
    );
    print(response.body.toString());
    // print(response.statusCode.toString());
    MyToken().clearToken();
  }
}
/* 
class ForgotPassword {
  final String? email;
  final String? inputPassword;
  final int? inputCode;
  final codeUrl = Uri.parse('http://$ip/api/password/forgot');
  final validatCodeUrl = Uri.parse('http://$ip/api/password/change');

  ForgotPassword({this.email, this.inputPassword, this.inputCode});

  Future<http.Response> sendCode() async {
    final response = await http.post(
      codeUrl,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "email": email!,
      }),
    );
    return response;
  }

  Future<http.Response> validatCode() async {
    final response = await http.post(
      validatCodeUrl,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "code": inputCode!,
        "password": inputPassword,
      }),
    );
    return response;
  }
}
 */
