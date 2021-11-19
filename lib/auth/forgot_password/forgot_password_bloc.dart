import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/auth/auth_cubit.dart';
import 'package:myapp/auth/forgot_password/forgot_password_event.dart';
import 'package:myapp/auth/forgot_password/forgot_password_state.dart';
import 'package:myapp/auth/repositories/auth_repository.dart';
import 'package:myapp/formStatus/form_submission_status.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final AuthRepository authRepo;
  final AuthCubit authCubit;

  ForgotPasswordBloc(this.authRepo, this.authCubit)
      : super(ForgotPasswordState());
  @override
  Stream<ForgotPasswordState> mapEventToState(
      ForgotPasswordEvent event) async* {
    if (event is ForgotPasswordEmailChanged) {
      yield state.copyWith(email: event.email);
    } else if (event is ForgotPasswordSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());
      try {
        ///
        final response = await authRepo.forgotPassword(state.email!);
        var data = jsonDecode(response.body);
        // print('response from forgotPasssword bloc ${response.body}');
        if (data['success']) {
          // print('this is ok ');
          authCubit.emit(AuthState.forgotPasswordReset);
        }
      } catch (e) {
        print('$e');
        yield state.copyWith(formStatus: SubmissionFailed('flail signUp'));
        throw Error();
      }
    }
  }
}
