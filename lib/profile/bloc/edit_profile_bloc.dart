import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/formStatus/form_submission_status.dart';
import 'package:myapp/profile/bloc/edit_profile_event.dart';
import 'package:myapp/profile/bloc/edit_profile_state.dart';
import 'package:myapp/profile/repository/profile_repository.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  ProfileRepository profileRepository;

  EditProfileBloc({required this.profileRepository})
      : super(EditProfileState());

  @override
  Stream<EditProfileState> mapEventToState(EditProfileEvent event) async* {
    if (event is EditProfileEmailChanged) {
      yield state.copyWith(email: event.email);
    }
    if (event is EditProfileUsernameChanged) {
      yield state.copyWith(username: event.username);
    }
    if (event is EditProfilePrefsChanged) {
      yield state.copyWith(prefs: event.prefs);
    }
    if (event is EditProfileFormSubmitted) {
      try {
        print('username ---- ${state.username}');
        final response = await profileRepository.editeProfileForm(
            state.username, state.email, state.prefs);

        var res = jsonDecode(response.body.toString());
        print('res=> ********** ' + res['success'].toString());

        if (res['success'] == true) {
          print('\n response success from edit bloccccccccccccccc\n' +
              response.body.toString());
          yield state.copyWith(formStatus: SubmissionSuccess());
        } else {
          print('\n response faild from edit bloccccccccccccccc\n' +
              response.body.toString());
          yield state.copyWith(
              formStatus: SubmissionFailed('Invalide information'));
          yield state.copyPasswordWith(passwordFormStatus: InitialFormStatus());
        }
      } catch (e) {
        print(e.toString());
      }
    }
    if (event is EditProfileNewPasswordChanged) {
      yield state.copyPasswordWith(newPassword: event.newPassword);
    }
    if (event is EditProfileOldPasswordChanged) {
      yield state.copyPasswordWith(oldPassword: event.oldPassword);
    }
    if (event is EditProfilePasswordSubmitted) {
      try {
        var response = await ProfileRepository()
            .changePassword(state.oldPassword, state.newPassword);
        print('passworddddd' + response.toString());
        if (response == 'Some thing went wrong try again') {
          yield state.copyPasswordWith(
              passwordFormStatus: SubmissionFailed(response));
          yield state.copyPasswordWith(passwordFormStatus: InitialFormStatus());
        } else {
          yield state.copyPasswordWith(passwordFormStatus: SubmissionSuccess());
        }
      } catch (e) {}
    }
  }
}
