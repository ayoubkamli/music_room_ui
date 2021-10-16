import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:myapp/auth/utils/manage_token.dart';
import 'package:myapp/constant/constant.dart';

class CreateEvent {
  final String name;
  final String desc;
  final List<String> pref;
  final String visibility;

  /// Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  CreateEvent(this.name, this.desc, this.pref, this.visibility);

  Future<http.Response> createEvent() async {
    /// final SharedPreferences prefs = await _prefs;
    /// String? token = prefs.getString('Token');
    String token = await MyToken().getToken();
    String bearerToken = 'Bearer $token';

    print(
        'creating event called $name / $desc / $visibility /$eventUrl / $pref');
    final response = await http.post(eventUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': '$bearerToken',
        },
        body: jsonEncode(<String, dynamic>{
          "name": name,
          "desc": desc,
          "musicPreference": pref,
          "visibility": visibility,
        }));
    print('response from create Event -event api- ${response.body}');
    return response;
  }
}

class GetAllEvents {
  /// Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late final response;
  Future<http.Response> fetchAllEvents() async {
    /// final SharedPreferences prefs = await _prefs;
    /// String? token = prefs.getString('Token');
    String token = await MyToken().getToken();
    String? bearerToken = 'Bearer: $token';

    print('fetch all event was called');
    try {
      response = await http.get(
        eventUrl,
        headers: <String, String>{
          'ContentType': 'application/json; charset=UTF-8',
          'Authorization': '$bearerToken',
        },
      );
    } catch (e) {
      print(e);
      throw Error();
    }

    print('response to string : ${response.body.toString()}');
    /*  print(
        'response of fetch event body: ${response.body} code: ${response.statusCode}'); */
    return response;
  }
}

class GetMyEvents {
  /// Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<http.Response> fetchAllMyEvents() async {
    /// final SharedPreferences prefs = await _prefs;
    /// String? token = prefs.getString('Token');
    String token = await MyToken().getToken();
    String? bearerToken = 'Bearer: $token';

    print('fetch My  events was called');

    final response = await http.get(
      eventUrl,
      headers: <String, String>{
        'ContentType': 'application/json; charset=UTF-8',
        'Authorization': '$bearerToken',
      },
    );
    // print(
    //  'response of fetch event body: ${response.body} code: ${response.statusCode}');
    return response;
  }
}

class GetEvent {
  /// Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<http.Response> fetchEvent() async {
    /// final SharedPreferences prefs = await _prefs;
    /// String? token = prefs.getString('Token');
    String token = await MyToken().getToken();
    String? bearerToken = 'Bearer: $token';

    String eventId = '';
    final Uri eventIdUrl = Uri.parse('$eventUrl/$eventId');
    print('fetch single event was called');

    final response = await http.get(
      eventIdUrl,
      headers: <String, String>{
        'ContentType': 'application/json; charset=UTF-8',
        'Authorization': '$bearerToken',
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

  /// Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  EditEvent(this.name, this.desc, this.musicPreference, this.visibility);

  Future<http.Response> editEvent() async {
    /// final SharedPreferences prefs = await _prefs;
    /// String? token = prefs.getString('Token');
    String token = await MyToken().getToken();
    String? bearerToken = 'Bearer: $token';

    String eventId = '';

    final Uri eventIdUrl = Uri.parse('$eventUrl/$eventId');

    print('editEvent was called');

    final response = await http.put(
      eventIdUrl,
      headers: <String, String>{
        'ContentType': 'application/json; charset=UTF-8',
        'Authorization': '$bearerToken',
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
