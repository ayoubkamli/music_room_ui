import 'package:myapp/formStatus/form_submission_status.dart';

class ForgotPasswordState {
  final String? email;
  final FormSubmissionStatus? formStatus;

  ForgotPasswordState({this.email, this.formStatus});

  ForgotPasswordState copyWith({
    String? email,
    FormSubmissionStatus? formStatus,
  }) {
    return ForgotPasswordState(
        email: email ?? this.email, formStatus: formStatus ?? this.formStatus);
  }
}
