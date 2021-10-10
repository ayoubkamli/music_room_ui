class AuthCredentials {
  final String? username;
  final String email;
  final String? password;
  String? userId;

  AuthCredentials(
      {this.username, required this.email, this.password, this.userId});
}
