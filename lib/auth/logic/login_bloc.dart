import 'dart:convert';

import 'package:myapp/auth/models/user.dart';
import 'package:myapp/auth/repositories/auth_credentials.dart';
import 'package:myapp/auth/logic/auth_cubit.dart';
import 'package:myapp/auth/repositories/auth_repository.dart';
import 'package:myapp/auth/utils/manage_token.dart';
import 'package:myapp/formStatus/form_submission_status.dart';
import 'package:myapp/auth/events/login_event.dart';
import 'package:myapp/auth/logic/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepo;
  final AuthCubit authCubit;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  User? user;

  LoginBloc(this.authRepo, this.authCubit) : super(LoginState());
  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    // Username updated
    if (event is LoginEmailChanged) {
      yield state.copyWith(username: event.email);

      //Password changed
    } else if (event is LoginPasswordChanged) {
      yield state.copyWith(password: event.password);

      //Form submitted
    } else if (event is LoginSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());

      try {
        final userData = await authRepo.login(
          state.email,
          state.password,
        );
        final data = jsonDecode(userData.body);
        print('this is the user data from login $data');
        if (data['success'] == true) {
          user = User.fromJson(data['data']);

          /// print('This is user from Usermodel ****** ' + user!.token.toString());
        }
        if (data['success'] == true && user!.isVerified == true) {
          /// SharedPreferences prefs = await _prefs;
          yield state.copyWith(formStatus: SubmissionSuccess());

          /// print('maaaaaaaaaaaaaaaaaaaaaann ' + user!.token.toString());

          /// await prefs.setString("Token", data["data"]["token"]);
          /// var p = prefs.getString("Token");
          /// print('this is the shared token ooooOOOOOoooo $p');
          MyToken().setToken(user!.token!);

          /// String tt = await MyToken().getToken();

          /// print('tttttttttttttttttttttttttt' + tt.toString());

          authCubit.launchSession(AuthCredentials(
            email: state.email,
          ));
        } else if (data['success'] == true &&
            data['data']['isVerified'] == false) {
          // confirm
          SharedPreferences prefs = await _prefs;
          await prefs.setString("Token", data["data"]["mailConfToken"]);
          authCubit.showConfirmationSignUp(
            email: state.email,
            password: state.password,
          );
        } else {
          throw Error();
        }
      } catch (e) {
        yield state.copyWith(formStatus: SubmissionFailed(e.toString()));
      }
    }
  }
}
