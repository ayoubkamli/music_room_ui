import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:myapp/explore/event/event_repository.dart';
import 'package:myapp/explore/event/event_state.dart';

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
        // print('dody --------------- from cubit ${jsonDecode(events.body)}');
        final data = jsonDecode(events.body);
        final datalist = data['data'];
        //  print('this is data list +++++++++++++++ $datalist');

        emit(LoadedState(datalist));
      } else {
        throw Error();
      }
    } catch (e) {
      emit(ErrorState());
    }
  }
}
