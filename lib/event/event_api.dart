import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:myapp/constant/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateEvent {
  final String name;
  final String desc;
  final List<String> musicPreference;
  final String visibility;

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  CreateEvent(this.name, this.desc, this.musicPreference, this.visibility);

  Future<http.Response> createEvent() async {
    final SharedPreferences prefs = await _prefs;
    String? token = prefs.getString('Token');
    //String bearerToken = 'Bearer $token';

    print('creating event called');
    final response = await http.post(eventUrl,
        headers: <String, String>{
          'ContentType': 'application/json; charset=UTF-8',
          'Authorization': '$token',
        },
        body: jsonEncode(<String, dynamic>{
          'name': name,
          'desc': desc,
          'musicPreference': musicPreference,
          'visibility': visibility,
        }));
    print('response from create Event $response');
    return response;
  }
}

class GetEvents {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<http.Response> fetchAllEvents() async {
    final SharedPreferences prefs = await _prefs;
    String? token = prefs.getString('Token');

    print('fetch all event was called');

    final response = await http.get(
      eventUrl,
      headers: <String, String>{
        'ContentType': 'application/json; charset=UTF-8',
        'Authorization': '$token',
      },
    );
    return response;
  }
}

class GetMyEvents {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<http.Response> fetchAllMyEvents() async {
    final SharedPreferences prefs = await _prefs;
    String? token = prefs.getString('Token');

    print('fetch all my events was called');

    final response = await http.get(
      eventUrl,
      headers: <String, String>{
        'ContentType': 'application/json; charset=UTF-8',
        'Authorization': '$token',
      },
    );
    return response;
  }
}

class GetEvent {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<http.Response> fetchEvent() async {
    final SharedPreferences prefs = await _prefs;
    String? token = prefs.getString('Token');
    String eventId = '';
    final Uri eventIdUrl = Uri.parse('$eventUrl/$eventId');
    print('fetch single event was called');

    final response = await http.get(
      eventIdUrl,
      headers: <String, String>{
        'ContentType': 'application/json; charset=UTF-8',
        'Authorization': '$token',
      },
    );
    return response;
  }
}

class EditEvent {
  final String name;
  final String desc;
  final List<String> musicPreference;
  final String visibility;

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  EditEvent(this.name, this.desc, this.musicPreference, this.visibility);

  Future<http.Response> editEvent() async {
    final SharedPreferences prefs = await _prefs;
    String? token = prefs.getString('Token');
    String eventId = '';

    final Uri eventIdUrl = Uri.parse('$eventUrl/$eventId');

    print('editEvent was called');

    final response = await http.put(
      eventIdUrl,
      headers: <String, String>{
        'ContentType': 'application/json; charset=UTF-8',
        'Authorization': '$token',
      },
      body: jsonEncode(
        <String, dynamic>{
          'name': name,
          'desc': desc,
          'musicPreference': musicPreference,
          'visibility': visibility,
        },
      ),
    );
    return response;
  }
}
