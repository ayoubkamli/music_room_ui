import 'package:myapp/formStatus/form_submission_status.dart';
import 'package:myapp/auth/utils/MyValidator.dart';

class LoginState {
  final String email;
  bool get isValidEmail => MyInputValidator().validateEmail(email);

  final String password;
  bool get isValidPassword => MyInputValidator().isPasswordValid(password);

  final FormSubmissionStatus formStatus;

  LoginState(
      {this.email = 'user001@gmail.com',
      this.password = 'User001@',
      this.formStatus = const InitialFormStatus()});

  LoginState copyWith({
    String? email,
    String? password,
    FormSubmissionStatus? formStatus,
  }) {
    return LoginState(
        email: email ?? this.email,
        password: password ?? this.password,
        formStatus: formStatus ?? this.formStatus);
  }
}
