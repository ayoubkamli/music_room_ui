import 'package:myapp/event/event_model.dart';

abstract class EventState {}

class InitialState extends EventState {
  List<Object> get props => [];
}

class LoadingState extends EventState {
  List<Object> get props => [];
}

class LoadedState extends EventState {
  final EventModel events;

  LoadedState(this.events);

  List<Object> get props => [events];
}

class ErrorState extends EventState {
  List<Object> get props => [];
}

///to do view for events