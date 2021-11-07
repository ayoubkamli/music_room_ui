import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/events/logic/mange_track_event_state.dart';

class TrackEventCubit extends Cubit<TrackEventState> {
  TrackEventCubit() : super(TrackEventInitState());

  static TrackEventCubit get(BuildContext context) {
    return BlocProvider.of(context);
  }

  String eventId = '';

  void putEventId() {
    eventId = 'lol';
  }

  bool addTrackToEvent() {
    return true;
  }

  bool removetrackFromEvent() {
    return true;
  }
}
