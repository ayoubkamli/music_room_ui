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
    String? token = await MyToken().getToken();
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
    String? token = await MyToken().getToken();
    String? bearerToken = 'Bearer: $token';

    // print('fetch all event was called');
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

    // print('response to string : ${response.body.toString()}');
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
    String? token = await MyToken().getToken();
    String? bearerToken = 'Bearer: $token';
    late http.Response response;
    // print('fetch My  events was called' + bearerToken);

    try {
      response = await http.get(
        Uri.parse('http://$ip/api/my-events'),
        headers: <String, String>{
          'ContentType': 'application/json; charset=UTF-8',
          'Authorization': '$bearerToken',
        },
      );
    } catch (e) {
      // print('yooooo' + e.toString());
      throw (e);
    }
    // print(
    // 'fffffffffffffffff f f f f f f fresponse of fetch event body: ${response.body} code: ${response.statusCode}');
    return response;
  }
}

class GetEvent {
  Future<http.Response> fetchEvent() async {
    String? token = await MyToken().getToken();
    String? bearerToken = 'Bearer: $token';

    String eventId = '';
    final Uri eventIdUrl = Uri.parse('$eventUrl/$eventId');
    // print('fetch single event was called');

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
  // final String name;
  // final String desc;
  // final List<String> musicPreference;
  // final String visibility;
  // final String id;

  /// Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  EditEvent();
  // this.name, this.desc, this.musicPreference, this.visibility, this.id);

  Future<http.Response> editEvent(
      name, desc, musicPreference, visibility, id) async {
    /// final SharedPreferences prefs = await _prefs;
    /// String? token = prefs.getString('Token');
    String? token = await MyToken().getToken();
    String? bearerToken = 'Bearer: $token';

    final Uri eventIdUrl = Uri.parse('$eventUrl/$id');

    // print('editEvent was called ${eventIdUrl.toString()}');
    // print('editEvent was data $name $desc $musicPreference $visibility');

    final response = await http.put(
      eventIdUrl,
      headers: <String, String>{
        'ContentType': 'application/json',
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': '$bearerToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'name': name,
          'desc': desc.toString(),
          'musicPreference': musicPreference,
          'visibility': visibility.toString(),
        },
      ),
    );
    print('yoooo   ' + response.body);
    return response;
  }
}

class RemoveEvent {
  Future<http.Response> deleteEvent(eventId) async {
    String? token = await MyToken().getToken();
    String? bearerToken = 'Bearer: $token';

    final Uri eventIdUrl = Uri.parse('$eventUrl/$eventId');
    print('delete event was called');

    final response = await http.delete(
      eventIdUrl,
      headers: <String, String>{
        'ContentType': 'application/json; charset=UTF-8',
        'Authorization': '$bearerToken',
      },
    );

    return response;
  }
}

class AddTrackToEvent {
  Future<http.Response> addTrackToEvent(eventId, trackId) async {
    String? token = await MyToken().getToken();
    String? bearerToken = 'Bearer: $token';

    final Uri eventIdUrl = Uri.parse('$eventUrl/$eventId/track');
    // print('add track to event was called');

    final response = await http.post(eventIdUrl,
        headers: <String, String>{
          'ContentType': 'application/json; charset=UTF-8',
          'Authorization': '$bearerToken',
        },
        body: jsonEncode(<String, dynamic>{
          "trackId": '$trackId',
        }));

    // print('this is the response body from add track to event api below');
    // print(response.body.toString());
    print('\n $eventId \n $trackId \n $token \n $eventIdUrl');

    return response;
  }
}

class RemoveTrackFromEvent {
  Future<http.Response> removeTrackToEvent(eventId, trackId) async {
    String? token = await MyToken().getToken();
    String? bearerToken = 'Bearer: $token';

    final Uri eventIdUrl = Uri.parse('$eventUrl/$eventId/track');
    // print('add track to event was called');

    final response = await http.delete(eventIdUrl,
        headers: <String, String>{
          'ContentType': 'application/json; charset=UTF-8',
          'Authorization': '$bearerToken',
        },
        body: jsonEncode(<String, dynamic>{
          "trackId": '$trackId',
        }));

    // print('this is the response body from remove track to event api below');
    // print(response.body.toString());
    // print('\n $eventId \n $trackId \n $token \n $eventIdUrl');

    return response;
  }
}
