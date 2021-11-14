import 'package:myapp/formStatus/form_submission_status.dart';

class EditProfileState {
  String email;
  String username;
  List<String> prefs;

  final FormSubmissionStatus formStatus;

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
