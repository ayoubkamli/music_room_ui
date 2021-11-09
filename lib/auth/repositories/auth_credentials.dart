import 'package:myapp/auth/models/user.dart';

class AuthCredentials {
  final String? username;
  final String? email;
  final String? password;
  User? user;

  AuthCredentials({this.username, this.email, this.password, this.user});
}
