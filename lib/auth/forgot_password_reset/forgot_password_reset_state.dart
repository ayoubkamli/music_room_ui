import 'package:myapp/auth/utils/MyValidator.dart';
import 'package:myapp/formStatus/form_submission_status.dart';

class ForgotPasswordResetState {
  final String code;
  final String newPassword;
  final FormSubmissionStatus formStatus;

  bool get isValidCode => code.length == 6;
  bool get isValidPassword => MyInputValidator().isPasswordValid(newPassword);

  ForgotPasswordResetState(
      {this.code = '',
      this.newPassword = '',
      this.formStatus = const InitialFormStatus()});

  ForgotPasswordResetState copyWith({
    String? code,
    String? newPassword,
    FormSubmissionStatus? formStatus,
  }) {
    return ForgotPasswordResetState(
      code: code ?? this.code,
      newPassword: newPassword ?? this.newPassword,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
