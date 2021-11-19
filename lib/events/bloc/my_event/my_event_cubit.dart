import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/events/bloc/my_event/my_events_state.dart';
import 'package:myapp/events/repositories/event_repository.dart';

class MyEventCubit extends Cubit<MyEventState> {
  final EventRepository eventRepository;
  MyEventCubit({required this.eventRepository}) : super(MyEventInitialState()) {
    getMyEvents();
  }

  Future<void> getMyEvents() async {
    // print('get all event called');
    try {
      // print('trying to laoding state');
      emit(MyEventLoadingState());
      final events = await eventRepository.getMyEvents();
      //print(events.statusCode);
      if (events.statusCode == 200) {
        final data = jsonDecode(events.body);
        final datalist = data['data'];

        emit(MyEventLoadedState(datalist));
      } else {
        throw Error();
      }
    } catch (e) {
      emit(MyEventErrorState());
    }
  }
}
