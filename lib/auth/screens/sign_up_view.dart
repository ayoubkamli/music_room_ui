import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/auth/auth_cubit.dart';
import 'package:myapp/auth/repositories/auth_repository.dart';
import 'package:myapp/formStatus/form_submission_status.dart';
import 'package:myapp/auth/signup/sign_up_bloc.dart';
import 'package:myapp/auth/signup/sign_up_event.dart';
import 'package:myapp/auth/signup/sign_up_state.dart';

class SignUpView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
          create: (context) => SignUpBloc(
              authRepo: context.read<AuthRepository>(),
              authCubit: context.read<AuthCubit>()),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [_signUpForm(), _loginAndForgot(context)],
          )),
    );
  }

  Widget _signUpForm() {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        final formStatus = state.formStatus;
        if (formStatus is SubmissionFailed) {
          _showSnackBar(context, formStatus.exception.toString());
        }
      },
      child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _usernameField(),
                _emailField(),
                _passwordField(),
                _signUpButton()
              ],
            ),
          )),
    );
  }

  Widget _usernameField() {
    return BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
      return TextFormField(
        decoration:
            InputDecoration(icon: Icon(Icons.person), hintText: 'Username'),
        validator: (value) => state.isValidUsername ? null : 'is too short',
        onChanged: (value) => context.read<SignUpBloc>().add(
              SignUpUsernameChanged(username: value),
            ),
      );
    });
  }

  Widget _emailField() {
    return BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
      return TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(icon: Icon(Icons.email), hintText: 'email'),
        validator: (value) => state.isValidemail ? null : 'Invalid email',
        onChanged: (value) => context.read<SignUpBloc>().add(
              SignUpEmailChanged(email: value),
            ),
      );
    });
  }

  Widget _passwordField() {
    return BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
      return TextFormField(
        obscureText: true,
        keyboardType: TextInputType.visiblePassword,
        decoration:
            InputDecoration(icon: Icon(Icons.security), hintText: 'Password'),
        validator: (value) => state.isValidPassword ? null : 'Invalid password',
        onChanged: (value) => context
            .read<SignUpBloc>()
            .add(SignUpPasswordChanged(password: value)),
      );
    });
  }

  Widget _signUpButton() {
    return BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
      return state.formStatus is FormSubmitting
          ? CircularProgressIndicator()
          : ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  context.read<SignUpBloc>().add(SignUpSubmitted());
                } else {
                  _showErrorText(context);
                }
              },
              child: Text('Sign Up'));
    });
  }

  Widget _loginAndForgot(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [_showLoginButton(context), _showForgotPassword(context)],
    );
  }

  Widget _showLoginButton(BuildContext context) {
    return Container(
        child: TextButton(
      child: Text('Already have an account? Login.'),
      onPressed: () => context.read<AuthCubit>().showLogin(),
    ));
  }

  Widget _showForgotPassword(BuildContext context) {
    return Container(
        child: TextButton(
      child: Text('Forgot password? Reset password.'),
      onPressed: () => context.read<AuthCubit>().showForgotPAssword(),
    ));
  }

  Widget _showErrorText(BuildContext context) {
    return Container(
      child: Text('error'),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
