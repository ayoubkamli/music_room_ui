import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/events/events/event_event.dart';
import 'package:myapp/events/logic/event_state.dart';
import 'package:myapp/events/models/event_model.dart';
import 'package:myapp/events/networking/event_api.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  EventBloc() : super(InitialState());

  @override
  Stream<EventState> mapEventToState(EventEvent event) async* {
    if (event is EventLoading) {
      yield LoadingState();
    }
    if (event is EventLoaded) {
      //try to get events list from api
      //await response and yield (EventLoaded(events))
      try {
        final events = GetAllEvents().fetchAllEvents();
        yield LoadedState(jsonDecode(events.toString()));
      } catch (e) {}
    }
    if (event is EventRefresh) {
      //try to get new data from the api and replace it to the view
      //await response and yield (EventLoaded(events))

    }
  }
}
