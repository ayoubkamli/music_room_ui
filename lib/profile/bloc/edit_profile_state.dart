import 'package:myapp/auth/models/user.dart';
import 'package:myapp/formStatus/form_submission_status.dart';
import 'package:myapp/profile/repository/profile_repository.dart';

class EditProfileState {
  String email;
  String username;
  List<String> prefs;
  late UserData profile;

  final FormSubmissionStatus formStatus;

  Future<UserData> data() async {
    UserData res = await ProfileRepository().getUserProfile();
    profile = res;
    return res;
  }

  EditProfileState(
      {this.email = '',
      this.username = '',
      this.prefs = const [],
      this.formStatus = const InitialFormStatus()});

  EditProfileState copyWith({
    String? email,
    String? username,
    List<String>? prefs,
    FormSubmissionStatus? formStatus,
  }) {
    return EditProfileState(
      email: email ?? this.email,
      username: username ?? this.username,
      prefs: prefs ?? this.prefs,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
