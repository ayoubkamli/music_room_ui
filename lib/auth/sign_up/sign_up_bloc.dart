import 'package:myapp/auth/auth_cubit.dart';
import 'package:myapp/auth/auth_repository.dart';
import 'package:myapp/auth/form_submission_status.dart';
import 'package:myapp/auth/sign_up/sign_up_event.dart';
import 'package:myapp/auth/sign_up/sign_up_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthRepository authRepo;
  final AuthCubit? authCubit;

  // String username = '';
  // String email = '';
  // String password = '';

  SignUpBloc({required this.authRepo, required this.authCubit})
      : super(SignUpState());
  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    //Username updated
    if (event is SignUpUsernameChanged) {
      yield state.copyWith(username: event.username);

      //Email update
    } else if (event is SignUpEmailChanged) {
      yield state.copyWith(email: event.email);

      //password changed
    } else if (event is SignUpPasswordChanged) {
      yield state.copyWith(password: event.password);

      //Form submitted
    } else if (event is SignUpSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());

      try {
        await authRepo.signUp(
          state.username,
          state.email,
          state.password,
        );
        yield state.copyWith(formStatus: SubmissionSuccess());
        authCubit!.showConfirmationSignUp(
          username: state.username,
          email: state.email,
          password: state.password,
        );
      } catch (e) {
        yield state.copyWith(formStatus: SubmissionFailed(e.toString()));
      }
    }
  }
}
