import 'package:myapp/auth/auth_api.dart';

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
    await Future.delayed(Duration(seconds: 2));
  }
}
