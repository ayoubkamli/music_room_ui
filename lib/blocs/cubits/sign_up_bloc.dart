import 'dart:convert';

import 'package:myapp/blocs/cubits/auth_cubit.dart';
import 'package:myapp/blocs/resources/auth_repository.dart';
import 'package:myapp/formStatus/form_submission_status.dart';
import 'package:myapp/blocs/events/sign_up_event.dart';
import 'package:myapp/blocs/states/sign_up_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthRepository authRepo;
  final AuthCubit? authCubit;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  SignUpBloc({required this.authRepo, required this.authCubit})
      : super(SignUpState());
  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    //Username updated
    if (event is SignUpUsernameChanged) {
      yield state.copyWith(username: event.username);

      //Email update
    } else if (event is SignUpEmailChanged) {
      yield state.copyWith(email: event.email);

      //password changed
    } else if (event is SignUpPasswordChanged) {
      yield state.copyWith(password: event.password);

      //Form submitted
    } else if (event is SignUpSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());

      try {
        var res = await authRepo.signUp(
          state.email,
          state.password,
        );
        print('this is the state====---------=========. ');

        var data = jsonDecode(res.body);
        // print('this is the data=====> ${data["data"]["mailConfCode"]}');
        // print('this is the data=====> ${data["data"]["mailConfToken"]}');
        print('this is the response=====> ${res.statusCode}');
        if (res.statusCode == 201) {
          print('this is the data=====> ${data["data"]["mailConfCode"]}');
          print('this is the data=====> ${data["data"]["mailConfToken"]}');
          SharedPreferences prefs = await _prefs;
          await prefs.setString("Token", data["data"]["mailConfToken"]);
          var p = prefs.getString("Token");
          print('this is the shared token ooooOOOOOoooo $p');
          authCubit!.showConfirmationSignUp(
            username: state.username,
            email: state.email,
            password: state.password,
          );
          yield state.copyWith(formStatus: SubmissionSuccess());
        } else {
          yield state.copyWith(formStatus: SubmissionFailed('flail signUp'));
          throw Error();
        }
      } catch (e) {
        yield state.copyWith(formStatus: SubmissionFailed(e.toString()));
      }
    }
  }
}
