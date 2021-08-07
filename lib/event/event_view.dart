import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/event/event_cubit.dart';
import 'package:myapp/event/event_state.dart';

class EventView extends StatefulWidget {
  @override
  _EventViewState createState() => _EventViewState();
}

class _EventViewState extends State<EventView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<EventCubit, EventState>(builder: (context, state) {
        if (state is LoadingState) {
          print('Loading state was very fast');
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is LoadedState) {
          final events = state.props;
          print(events);
          print('this is evets from viewwwwwwwwwww ${state.events}');
          return ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) => Card(
                    child: ListTile(
                      title: Text('${events[index][0]["name"]}'),
                    ),
                  ));
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
    );
  }
}
