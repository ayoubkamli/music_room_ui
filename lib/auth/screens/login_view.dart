import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/auth/blocs/auth_cubit.dart';
import 'package:myapp/auth/repositories/auth_repository.dart';
import 'package:myapp/formStatus/form_submission_status.dart';
import 'package:myapp/auth/blocs/login_bloc.dart';
import 'package:myapp/auth/events/login_event.dart';
import 'package:myapp/auth/repositories/login_state.dart';

class LoginView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
          create: (context) => LoginBloc(
              context.read<AuthRepository>(), context.read<AuthCubit>()),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              _loginForm(),
              _showSignUpButton(context),
            ],
          )),
    );
  }

  Widget _loginForm() {
    return BlocListener<LoginBloc, LoginState>(
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
                _emailField(),
                _passwordField(),
                _loginButton(),
              ],
            ),
          )),
    );
  }

  Widget _emailField() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            icon: Icon(Icons.email), hintText: 'Email@eample.com'),
        validator: (value) => state.isValidEmail ? null : 'Invalid email',
        onChanged: (value) => context.read<LoginBloc>().add(
              LoginEmailChanged(email: value),
            ),
      );
    });
  }

  Widget _passwordField() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return TextFormField(
        obscureText: true,
        decoration:
            InputDecoration(icon: Icon(Icons.security), hintText: 'Password'),
        validator: (value) => state.isValidPassword ? null : 'Invalid password',
        onChanged: (value) => context
            .read<LoginBloc>()
            .add(LoginPasswordChanged(password: value)),
      );
    });
  }

  Widget _loginButton() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return state.formStatus is FormSubmitting
          ? CircularProgressIndicator()
          : ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  context.read<LoginBloc>().add(LoginSubmitted());
                }
              },
              child: Text('Login'));
    });
  }

  Widget _showSignUpButton(BuildContext context) {
    return SafeArea(
        child: TextButton(
      child: Text('Don\'t have an account? Sign up.'),
      onPressed: () => context.read<AuthCubit>().showSignUp(),
    ));
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
