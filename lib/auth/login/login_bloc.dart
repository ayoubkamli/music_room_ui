import 'package:myapp/auth/auth_credentials.dart';
import 'package:myapp/auth/auth_cubit.dart';
import 'package:myapp/auth/auth_repository.dart';
import 'package:myapp/auth/form_submission_status.dart';
import 'package:myapp/auth/login/login_event.dart';
import 'package:myapp/auth/login/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepo;
  final AuthCubit authCubit;

  LoginBloc(this.authRepo, this.authCubit) : super(LoginState());
  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    // Username updated
    if (event is LoginUsernameChanged) {
      yield state.copyWith(username: event.username);

      //Password changed
    } else if (event is LoginPasswordChanged) {
      yield state.copyWith(password: event.password);

      //Form submitted
    } else if (event is LoginSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());

      try {
        final userId = await authRepo.login(
          state.username,
          state.password,
        );
        yield state.copyWith(formStatus: SubmissionSuccess());

        authCubit.launchSession(AuthCredentials(
          username: state.username,
          userId: userId,
        ));
      } catch (e) {
        yield state.copyWith(formStatus: SubmissionFailed(e.toString()));
      }
    }
  }
}
