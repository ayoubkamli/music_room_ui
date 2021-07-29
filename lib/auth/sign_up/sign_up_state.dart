import 'package:myapp/auth/form_submission_status.dart';
import 'package:myapp/auth/validation/MyValidator.dart';

class SignUpState {
  final String username;
  bool get isValidUsername => username.length > 3;

  final String email;
  bool get isValidemail => MyInputValidator().validateEmail(email);

  final String password;
  bool get isValidPassword => MyInputValidator().isPasswordValid(password);

  final FormSubmissionStatus formStatus;

  SignUpState(
      {this.username = '',
      this.password = '',
      this.email = '',
      this.formStatus = const InitialFormStatus()});

  SignUpState copyWith({
    String? username,
    String? email,
    String? password,
    FormSubmissionStatus? formStatus,
  }) {
    return SignUpState(
        username: username ?? this.username,
        email: email ?? this.email,
        password: password ?? this.password,
        formStatus: formStatus ?? this.formStatus);
  }
}
