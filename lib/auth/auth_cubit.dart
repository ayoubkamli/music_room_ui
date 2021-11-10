import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/auth/models/user.dart';
import 'package:myapp/auth/repositories/auth_credentials.dart';
import 'package:myapp/auth/session_cubit.dart';

enum AuthState {
  login,
  signUp,
  confirmationSignUp,
  forgotPassword,
  forgotPasswordReset
}

class AuthCubit extends Cubit<AuthState> {
  final SessionCubit? sessionCubit;

  AuthCubit({this.sessionCubit}) : super(AuthState.login);

  AuthCredentials? credentials;

  void showLogin() => emit(AuthState.login);
  void showSignUp() => emit(AuthState.signUp);
  void showForgotPAssword() => emit(AuthState.forgotPassword);
  void showForgotPasswordReset() => emit(AuthState.forgotPasswordReset);

  void showConfirmationSignUp({
    String? username,
    required String email,
    String? password,
    User? user,
  }) {
    credentials = AuthCredentials(
      username: username,
      email: email,
      password: password,
      user: user,
    );
    emit(AuthState.confirmationSignUp);
  }

  void launchSession(AuthCredentials credentials) =>
      sessionCubit!.showSession(credentials);
}
