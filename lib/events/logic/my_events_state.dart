abstract class MyEventState {
  set events(List<dynamic> myEvents) {}
}

class MyEventInitialState extends MyEventState {
  List<dynamic> get props => [];
}

class MyEventLoadingState extends MyEventState {
  List<dynamic> get props => [];
}

class MyEventLoadedState extends MyEventState {
  final List<dynamic> myEvents;

  MyEventLoadedState(this.myEvents);

  List<dynamic> get props => [myEvents];
}

class MyEventErrorState extends MyEventState {
  List<dynamic> get props => [];
}

///to do view for events
