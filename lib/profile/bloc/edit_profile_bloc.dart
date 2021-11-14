import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/formStatus/form_submission_status.dart';
import 'package:myapp/profile/bloc/edit_profile_event.dart';
import 'package:myapp/profile/bloc/edit_profile_state.dart';
import 'package:myapp/profile/repository/profile_repository.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  ProfileRepository repository;

  EditProfileBloc(this.repository) : super(EditProfileState());

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
    if (event is EditProfileSubmitted) {
      try {
        final response = await repository.editeProfile(
            state.username, state.email, state.prefs);
        print(response.body.toString());
        yield state.copyWith(formStatus: SubmissionSuccess());
      } catch (e) {
        print(e.toString());
      }
    }
  }
}
