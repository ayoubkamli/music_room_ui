import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// import 'package:myapp/explore/event/event_cubit.dart';
import 'package:myapp/blocs/cubits/session_cubit.dart';

class SessionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            child: Row(
          children: [
            Text("Session"),
            SizedBox(
              height: 20,
            ),

            /// _eventButton(context),
            _signOutButton(context),
          ],
        )),
      ),
    );
  }

  /// Widget _eventButton(BuildContext context) {
  ///   return SafeArea(
  ///       child: TextButton(
  ///     child: Text('Event '),
  ///     onPressed: () => context.read<EventCubit>().getAllEvents(),
  ///   ));
  /// }

  Widget _signOutButton(BuildContext context) {
    return SafeArea(
        child: TextButton(
      child: Text('SignOut'),
      onPressed: () => context.read<SessionCubit>().signOut(),
    ));
  }
}
