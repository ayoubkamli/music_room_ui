import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:myapp/event/event_api.dart';

class EventRepository {
  Future<http.Response> createEvent({
    String name = 'first name',
    String desc = 'description',
    List<dynamic>? musicPreference,
    String visibility = 'private',
  }) async {
    final response = await CreateEvent(name, desc, musicPreference!, visibility)
        .createEvent();
    return response;
  }

  Future<http.Response> getEvents() async {
    print('get event from repos was called');
    final response = await GetAllEvents().fetchAllEvents();
    print('response from get event in repo ${jsonDecode(response.body)}');
    return response;
  }

  Future<List<dynamic>> getMyEvents() async {
    final response = await GetMyEvents().fetchAllMyEvents();
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
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
