import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/auth/auth_cubit.dart';
import 'package:myapp/auth/forgot_password_reset/forgot_password_reset_event.dart';
import 'package:myapp/auth/forgot_password_reset/forgot_password_reset_state.dart';
import 'package:myapp/auth/repositories/auth_repository.dart';
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
    } else if (event is ForgotPasswordResetSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());

      try {
        final response = await authRepo.resetForgotPassword(
            confirmationCode: state.code, newPassword: state.newPassword);
        yield state.copyWith(formStatus: SubmissionSuccess());
        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          if (data["success"] == true) authCubit.showLogin();
        }
      } catch (e) {
        print(e.toString());
      }
    }
  }
}
