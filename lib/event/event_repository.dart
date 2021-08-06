import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:myapp/event/event_api.dart';
import 'package:myapp/event/event_model.dart';

class EventRepository {
  Future<http.Response> createEvent(
    String name,
    String desc,
    List<String> musicPreference,
    String visibility,
  ) async {
    final response = await CreateEvent(name, desc, musicPreference, visibility)
        .createEvent();
    return response;
  }

  Future<EventModel> getEvents() async {
    final response = await GetEvent().fetchEvent();
    if (response.statusCode == 200) {
      return EventModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('FALID LAODING DATA EVENTS');
    }
  }

  Future<EventModel> getMyEvents() async {
    final response = await GetMyEvents().fetchAllMyEvents();
    if (response.statusCode == 200) {
      return EventModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('FALID LAODING DATA EVENTS');
    }
  }

  Future<http.Response> editEvent(
    String name,
    String desc,
    List<String> musicPreference,
    String visibility,
  ) async {
    final response =
        await EditEvent(name, desc, musicPreference, visibility).editEvent();
    return response;
  }
}
