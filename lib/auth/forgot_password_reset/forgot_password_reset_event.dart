abstract class ForgotPasswordResetEvent {}

class ForgotPasswordConfirmationCodeChanged extends ForgotPasswordResetEvent {
  final String? code;

  ForgotPasswordConfirmationCodeChanged({this.code});
}

class ForgotPasswordNewPasswordChanged extends ForgotPasswordResetEvent {
  final String? newPassword;
  ForgotPasswordNewPasswordChanged({this.newPassword});
}

class ForgotPasswordResetSubmitted extends ForgotPasswordResetEvent {}
