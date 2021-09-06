import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/explore/widget/body.dart';

import 'event_cubit.dart';
import 'event_state.dart';

class EventHomeScreen extends StatefulWidget {
  const EventHomeScreen({Key? key}) : super(key: key);

  @override
  _EventHomeScreenState createState() => _EventHomeScreenState();
}

class _EventHomeScreenState extends State<EventHomeScreen> {
  // int activeMenu1 = 0;
  int activeMenu2 = 0;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventCubit, EventState>(
      builder: (context, state) {
        return Container(
          child: BlocBuilder<EventCubit, EventState>(builder: (context, state) {
            if (state is LoadingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is LoadedState) {
              final events = state.props;
              return getBody(events, 'Explore Events', context);
            } else if (state is ErrorState) {
              print('${state.props}');
              return Center(
                  child: Icon(
                Icons.close,
              ));
            } else {
              return Container();
            }
          }),

          /// floatingActionButton: FloatingActionButton.extended(
          ///   onPressed: () {
          ///     Navigator.push(
          ///       context,
          ///       MaterialPageRoute(builder: (context) => CreateEventView()),
          ///     );
          ///   },
          ///   label: const Text('ADD EVENT'),
          ///   icon: const Icon(Icons.add),
          ///   backgroundColor: Colors.green,
          /// ),
        );
      },
    );
  }
}
