import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/auth/auth_cubit.dart';
import 'package:myapp/auth/forgot_password/forgot_password_bloc.dart';
import 'package:myapp/auth/forgot_password/forgot_password_event.dart';
import 'package:myapp/auth/forgot_password/forgot_password_state.dart';
import 'package:myapp/auth/repositories/auth_repository.dart';
import 'package:myapp/formStatus/form_submission_status.dart';

class ForgotPasswordView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
          create: (context) => ForgotPasswordBloc(
              context.read<AuthRepository>(), context.read<AuthCubit>()),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              _forgotPasswordForm(),
              _showSignUpButton(context),
            ],
          )),
    );
  }

  Widget _forgotPasswordForm() {
    return BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
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
                _sendEmailButton(),
              ],
            ),
          )),
    );
  }

  Widget _emailField() {
    return BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
        builder: (context, state) {
      return TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            icon: Icon(Icons.email), hintText: 'Email@eample.com'),
        onChanged: (value) => context.read<ForgotPasswordBloc>().add(
              ForgotPasswordEmailChanged(email: value),
            ),
      );
    });
  }

  Widget _sendEmailButton() {
    return BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
        builder: (context, state) {
      return state.formStatus is FormSubmitting
          ? CircularProgressIndicator()
          : ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  context
                      .read<ForgotPasswordBloc>()
                      .add(ForgotPasswordSubmitted());
                }
              },
              child: Text('Send email'));
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
