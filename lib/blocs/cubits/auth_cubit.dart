import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/blocs/auth_navigation/auth_credentials.dart';
import 'package:myapp/blocs/cubits/session_cubit.dart';

enum AuthState { login, signUp, confirmationSignUp }

class AuthCubit extends Cubit<AuthState> {
  final SessionCubit? sessionCubit;

  AuthCubit({this.sessionCubit}) : super(AuthState.login);

  AuthCredentials? credentials;

  void showLogin() => emit(AuthState.login);
  void showSignUp() => emit(AuthState.signUp);
  void showConfirmationSignUp({
    String? username,
    required String email,
    String? password,
  }) {
    credentials = AuthCredentials(
      username: username,
      email: email,
      password: password,
    );
    emit(AuthState.confirmationSignUp);
  }

  void launchSession(AuthCredentials credentials) =>
      sessionCubit!.showSession(credentials);
}
