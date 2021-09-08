import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/blocs/cubits/auth_cubit.dart';
import 'package:myapp/blocs/resources/auth_repository.dart';
import 'package:myapp/formStatus/form_submission_status.dart';
import 'package:myapp/blocs/cubits/confirm_bloc.dart';
import 'package:myapp/blocs/events/confirm_event.dart';
import 'package:myapp/blocs/states/confirm_state.dart';

class ConfirmationView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
          create: (context) => ConfirmationBloc(
              authRepo: context.read<AuthRepository>(),
              authCubit: context.read<AuthCubit>()),
          child: _confirmationForm()),
    );
  }

  Widget _confirmationForm() {
    return BlocListener<ConfirmationBloc, ConfirmationState>(
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
                _confirmationButton(),
              ],
            ),
          )),
    );
  }

  Widget _codeField() {
    return BlocBuilder<ConfirmationBloc, ConfirmationState>(
        builder: (context, state) {
      return TextFormField(
        decoration: InputDecoration(
            icon: Icon(Icons.person), hintText: 'Confirmation code'),
        keyboardType: TextInputType.number,
        validator: (value) =>
            state.isValidCode ? null : 'Invalid confirmation code',
        onChanged: (value) => context.read<ConfirmationBloc>().add(
              ConfirmationCodeChanged(code: value),
            ),
      );
    });
  }

  Widget _confirmationButton() {
    return BlocBuilder<ConfirmationBloc, ConfirmationState>(
        builder: (context, state) {
      return state.formStatus is FormSubmitting
          ? CircularProgressIndicator()
          : ElevatedButton(
              onPressed: () {
                // if (_formKey.currentState!.validate()) {
                context.read<ConfirmationBloc>().add(ConfirmationSubmitted());
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
