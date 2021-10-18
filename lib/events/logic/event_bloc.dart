import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/events/events/event_event.dart';
import 'package:myapp/events/logic/event_state.dart';
import 'package:myapp/events/networking/event_api.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  EventBloc() : super(InitialState());

  @override
  Stream<EventState> mapEventToState(EventEvent event) async* {
    if (event is EventLoading) {
      try {
        final events = GetAllEvents().fetchAllEvents();
        yield LoadedState(jsonDecode(events.toString()));
      } catch (e) {
        yield ErrorState();
      }
      yield LoadingState();
    }
    if (event is EventRefresh) {
      yield RefreshState();
      final events = GetAllEvents().fetchAllEvents();
      yield LoadedState(jsonDecode(events.toString()));
    }
  }
}
