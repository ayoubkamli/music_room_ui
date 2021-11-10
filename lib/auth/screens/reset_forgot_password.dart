import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/auth/auth_cubit.dart';
import 'package:myapp/auth/forgot_password_reset/forgot_password_reset_bloc.dart';
import 'package:myapp/auth/forgot_password_reset/forgot_password_reset_event.dart';
import 'package:myapp/auth/forgot_password_reset/forgot_password_reset_state.dart';
import 'package:myapp/auth/repositories/auth_repository.dart';
import 'package:myapp/formStatus/form_submission_status.dart';

class ResetForgotPassword extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    ///authRepo: context.read<AuthRepository>(),
    /// authCubit: context.read<AuthCubit>()
    return Scaffold(
        body: BlocProvider(
            create: (context) => ForgotPasswordResetBloc(
                authRepo: context.read<AuthRepository>(),
                authCubit: context.read<AuthCubit>()),
            child: _confirmationForm()));
  }

  Widget _confirmationForm() {
    return BlocListener<ForgotPasswordResetBloc, ForgotPasswordResetState>(
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
                _codeField(),
                _passwordField(),
                _confirmationButton(),
              ],
            ),
          )),
    );
  }

  Widget _codeField() {
    return BlocBuilder<ForgotPasswordResetBloc, ForgotPasswordResetState>(
        builder: (context, state) {
      return TextFormField(
        decoration: InputDecoration(
            icon: Icon(Icons.person), hintText: 'Confirmation code'),
        keyboardType: TextInputType.number,
        validator: (value) =>
            state.isValidCode ? null : 'Invalid confirmation code',
        onChanged: (value) => context.read<ForgotPasswordResetBloc>().add(
              ForgotPasswordConfirmationCodeChanged(code: value),
            ),
      );
    });
  }

  Widget _passwordField() {
    return BlocBuilder<ForgotPasswordResetBloc, ForgotPasswordResetState>(
        builder: (context, state) {
      return TextFormField(
        obscureText: true,
        keyboardType: TextInputType.visiblePassword,
        decoration:
            InputDecoration(icon: Icon(Icons.security), hintText: 'Password'),
        validator: (value) => state.isValidPassword ? null : 'Invalid password',
        onChanged: (value) => context
            .read<ForgotPasswordResetBloc>()
            .add(ForgotPasswordNewPasswordChanged(newPassword: value)),
      );
    });
  }

  Widget _confirmationButton() {
    return BlocBuilder<ForgotPasswordResetBloc, ForgotPasswordResetState>(
        builder: (context, state) {
      return state.formStatus is FormSubmitting
          ? CircularProgressIndicator()
          : ElevatedButton(
              onPressed: () {
                // if (_formKey.currentState!.validate()) {
                context
                    .read<ForgotPasswordResetBloc>()
                    .add(ForgotPAsswordSubmitted());
                print('${_formKey.currentState!.validate()}');
                // }
              },
              child: Text('Confirm'));
    });
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
