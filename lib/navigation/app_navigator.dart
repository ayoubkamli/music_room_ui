import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/auth/logic/auth_cubit.dart';
import 'package:myapp/navigation/auth_navigator.dart';
import 'package:myapp/pages/explore_view.dart';

import 'package:myapp/utils/loading_view.dart';
import 'package:myapp/auth/logic/session_cubit.dart';
import 'package:myapp/auth/logic/session_state.dart';

class AppNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionCubit, SessionState>(builder: (context, state) {
      return Navigator(
        pages: [
          if (state is UnknownSessionState) MaterialPage(child: LoadingView()),
          if (state is Unauthenticated)
            MaterialPage(
                child: BlocProvider(
              create: (context) =>
                  AuthCubit(sessionCubit: context.read<SessionCubit>()),
              child: AuthNavigator(),
            )),
          if (state is Authenticated)
            MaterialPage(
              child: ExploreView(),
            )
        ],
        onPopPage: (route, result) => route.didPop(result),
      );
    });
  }
}
