abstract class EditProfileEvent {}

class EditProfileInitialEvent extends EditProfileEvent {}

class EditProfileUsernameChanged extends EditProfileEvent {
  final String? username;

  EditProfileUsernameChanged({this.username});
}

class EditProfileEmailChanged extends EditProfileEvent {
  final String? email;

  EditProfileEmailChanged({this.email});
}

class EditProfilePrefsChanged extends EditProfileEvent {
  final List<String>? prefs;

  EditProfilePrefsChanged({this.prefs});
}

class EditProfileFormSubmitted extends EditProfileEvent {}

// class EditProfileImageSubmitted extends EditProfileEvent {}

class EditProfileOldPasswordChanged extends EditProfileEvent {
  final String? oldPassword;

  EditProfileOldPasswordChanged({required this.oldPassword});
}

class EditProfileNewPasswordChanged extends EditProfileEvent {
  final String? newPassword;

  EditProfileNewPasswordChanged({required this.newPassword});
}

class EditProfilePasswordSubmitted extends EditProfileEvent {}
