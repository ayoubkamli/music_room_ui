import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/blocs/cubits/auth_cubit.dart';
import 'package:myapp/pages/confirm_view.dart';
import 'package:myapp/pages/login_view.dart';
import 'package:myapp/pages/sign_up_view.dart';

class AuthNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
      return Navigator(
        pages: [
          //show login
          if (state == AuthState.login)
            MaterialPage(
              child: LoginView(),
            ),
          //allow oush animation
          if (state == AuthState.signUp ||
              state == AuthState.confirmationSignUp) ...[
            //show sign up
            MaterialPage(child: SignUpView()),
            //shoe confirm sign up
            if (state == AuthState.confirmationSignUp)
              MaterialPage(child: ConfirmationView())
          ]
        ],
        onPopPage: (route, result) => route.didPop(result),
      );
    });
  }
}
