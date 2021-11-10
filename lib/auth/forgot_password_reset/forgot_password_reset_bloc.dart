import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/auth/auth_cubit.dart';
import 'package:myapp/auth/forgot_password/forgot_password_event.dart';
import 'package:myapp/auth/forgot_password_reset/forgot_password_reset_event.dart';
import 'package:myapp/auth/forgot_password_reset/forgot_password_reset_state.dart';
import 'package:myapp/auth/models/user.dart';
import 'package:myapp/auth/repositories/auth_repository.dart';
import 'package:myapp/auth/utils/manage_token.dart';
import 'package:myapp/formStatus/form_submission_status.dart';

class ForgotPasswordResetBloc
    extends Bloc<ForgotPasswordResetEvent, ForgotPasswordResetState> {
  final AuthRepository authRepo;
  final AuthCubit authCubit;

  ForgotPasswordResetBloc({required this.authRepo, required this.authCubit})
      : super(ForgotPasswordResetState());
  @override
  Stream<ForgotPasswordResetState> mapEventToState(
      ForgotPasswordResetEvent event) async* {
    if (event is ForgotPasswordConfirmationCodeChanged) {
      yield state.copyWith(code: event.code);
    } else if (event is ForgotPasswordNewPasswordChanged) {
      yield state.copyWith(newPassword: event.newPassword);
    } else if (event is ForgotPasswordSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());

      try {
        print(
            '99999999 this is the response body from forgot password reset bloc 99999999 \n');

        final response = await authRepo.resetForgotPassword(
            confirmationCode: state.code, newPassword: state.newPassword);

        print(
            '99999999 this is the response body from forgot password reset bloc 99999999 \n');
        print(response.body.toString());

        yield state.copyWith(formStatus: SubmissionSuccess());
        final credentials = authCubit.credentials;
        //credentials!.userId = userId;
        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);

          final user = User.fromJson(data);
          credentials!.user = user;

          String token = data['data']['token'];
          MyToken().setToken(token);
          print('credentilas are => $data');
          if (data["success"] == true) authCubit.launchSession(credentials);
        }
      } catch (e) {
        print(e.toString());
      }
    }
  }
}
