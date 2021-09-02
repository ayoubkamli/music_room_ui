abstract class EventState {
  set events(List<dynamic> events) {}
}

class InitialState extends EventState {
  List<dynamic> get props => [];
}

class LoadingState extends EventState {
  List<dynamic> get props => [];
}

class LoadedState extends EventState {
  final List<dynamic> events;

  LoadedState(this.events);

  List<dynamic> get props => [events];
}

class ErrorState extends EventState {
  List<dynamic> get props => [];
}

///to do view for events