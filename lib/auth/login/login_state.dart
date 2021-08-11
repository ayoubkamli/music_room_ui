import 'package:myapp/auth/form_submission_status.dart';
import 'package:myapp/auth/validation/MyValidator.dart';

class LoginState {
  final String email;
  bool get isValidEmail => MyInputValidator().validateEmail(email);

  final String password;
  bool get isValidPassword => MyInputValidator().isPasswordValid(password);

  final FormSubmissionStatus formStatus;

  LoginState(
      {this.email = 'user081@gmail.com',
      this.password = 'User081*',
      this.formStatus = const InitialFormStatus()});

  LoginState copyWith({
    String? username,
    String? password,
    FormSubmissionStatus? formStatus,
  }) {
    return LoginState(
        email: username ?? this.email,
        password: password ?? this.password,
        formStatus: formStatus ?? this.formStatus);
  }
}
