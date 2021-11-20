import 'package:myapp/auth/models/user.dart';
import 'package:myapp/auth/utils/MyValidator.dart';
import 'package:myapp/formStatus/form_submission_status.dart';
import 'package:myapp/profile/repository/profile_repository.dart';

class EditProfileState {
  String email;
  String username;
  List<String> prefs;
  late UserData profile;
  String oldPassword;

  final String newPassword;
  bool get isValidPassword => MyInputValidator().isPasswordValid(newPassword);

  final FormSubmissionStatus formStatus;

  Future<UserData> data() async {
    UserData res = await ProfileRepository().getUserProfile();
    profile = res;
    return res;
  }

  EditProfileState(
      {this.newPassword = '',
      this.oldPassword = '',
      this.email = '',
      this.username = 'test from state',
      this.prefs = const [],
      this.formStatus = const InitialFormStatus()});

  EditProfileState copyPasswordWith(
      {String? newPassword, String? oldPassword}) {
    return EditProfileState(
        newPassword: newPassword ?? this.newPassword,
        oldPassword: oldPassword ?? this.oldPassword);
  }

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
