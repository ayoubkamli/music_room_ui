import 'dart:convert';

import 'package:myapp/auth/auth_cubit.dart';
import 'package:myapp/auth/auth_repository.dart';
import 'package:myapp/auth/form_submission_status.dart';
import 'package:myapp/auth/confirm/confirm_event.dart';
import 'package:myapp/auth/confirm/confirm_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfirmationBloc extends Bloc<ConfirmationEvent, ConfirmationState> {
  final AuthRepository authRepo;
  final AuthCubit authCubit;

  ConfirmationBloc({
    required this.authRepo,
    required this.authCubit,
  }) : super(ConfirmationState());

  @override
  Stream<ConfirmationState> mapEventToState(ConfirmationEvent event) async* {
    if (event is ConfirmationCodeChanged) {
      yield state.copyWith(code: event.code);
    } else if (event is ConfirmationSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());

      try {
        final userId = await authRepo.confirmationSignUp(
          //username: authCubit.credentials!.username,
          confirmationCode: state.code,
        );
        yield state.copyWith(formStatus: SubmissionSuccess());

        final credentials = authCubit.credentials;
        //credentials!.userId = userId;

        var data = jsonDecode(userId.body);

        print('credentilas are => ${data["success"]}');
        if (data['success'] == false) authCubit.launchSession(credentials!);
      } catch (e) {
        yield state.copyWith(formStatus: SubmissionFailed(e.toString()));
      }
    }
  }
}
