import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/events/logic/mange_track_event_state.dart';
import 'package:myapp/events/networking/event_api.dart';

class TrackEventCubit extends Cubit<TrackEventState> {
  TrackEventCubit() : super(TrackEventInitState());

  static TrackEventCubit get(BuildContext context) {
    return BlocProvider.of(context);
  }

  String eventId = '';

  void putEventId() {
    eventId = 'lol';
  }

  Future<bool> addTrackToEvent(String eventId, String trackId) async {
    http.Response response =
        await AddTrackToEvent().addTrackToEvent(eventId, trackId);
    if (response.statusCode == 200) {
      return Future<bool>.value(true);
    }
    return Future<bool>.value(true);
  }

  void remove(String eventId, String trackId) {
    removetrackFromEvent(eventId, trackId);
  }

  Future<bool> removetrackFromEvent(String eventId, String trackId) async {
    http.Response response =
        await RemoveTrackFromEvent().removeTrackToEvent(eventId, trackId);

    if (response.statusCode == 200) {
      print('ok ${response.statusCode}');
      print('\n ${response.body.toString()}');
      return true;
    }

    print('status code from the event api ${response.statusCode}');
    return false;
  }
}
