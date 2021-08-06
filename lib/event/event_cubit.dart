import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/event/event_repository.dart';
import 'package:myapp/event/event_state.dart';

class EventCubit extends Cubit<EventState> {
  final EventRepository repository;
  EventCubit(this.repository) : super(InitialState()) {
    getAllEvents();
  }

  void getAllEvents() async {
    try {
      emit(LoadingState());
      final events = await repository.getEvents();
      emit(LoadedState(events));
    } catch (e) {
      emit(ErrorState());
    }
  }
}
