import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/events/bloc/all_event/event_state.dart';
import 'package:myapp/events/repositories/event_repository.dart';

class EventCubit extends Cubit<EventState> {
  final EventRepository eventRepository;
  EventCubit({required this.eventRepository}) : super(InitialState()) {
    getAllEvents();
  }

  Future<void> getAllEvents() async {
    print('get all event called');
    try {
      print('trying to laoding state');
      emit(LoadingState());
      final events = await eventRepository.getEvents();
      //print(events.statusCode);
      if (events.statusCode == 200) {
        final data = jsonDecode(events.body);
        final datalist = data['data'];

        emit(LoadedState(datalist));
      } else {
        throw Error();
      }
    } catch (e) {
      emit(ErrorState());
    }
  }
}
