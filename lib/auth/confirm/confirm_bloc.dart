import 'dart:convert';

import 'package:myapp/auth/auth_cubit.dart';
import 'package:myapp/auth/models/user.dart';
import 'package:myapp/auth/repositories/auth_repository.dart';
import 'package:myapp/formStatus/form_submission_status.dart';
import 'package:myapp/auth/confirm/confirm_event.dart';
import 'package:myapp/auth/confirm/confirm_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfirmationBloc extends Bloc<ConfirmationEvent, ConfirmationState> {
  final AuthRepository authRepo;
  final AuthCubit authCubit;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

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
        final response = await authRepo.confirmationSignUp(
          //username: authCubit.credentials!.username,
          confirmationCode: state.code,
        );

        print('\n ************************************* \n');

        print(response.body.toString());
        yield state.copyWith(formStatus: SubmissionSuccess());

        final credentials = authCubit.credentials;
        //credentials!.userId = userId;
        if (response.statusCode == 200) {
          final SharedPreferences prefs = await _prefs;
          var data = jsonDecode(response.body);

          final user = User.fromJson(data);
          credentials!.user = user;

          String token = data['data']['token'];
          prefs.setString('Token', token);
          print('credentilas are => $data');
          if (data["success"] == true) authCubit.launchSession(credentials);
        }
      } catch (e) {
        yield state.copyWith(formStatus: SubmissionFailed(e.toString()));
      }
    }
  }
}
