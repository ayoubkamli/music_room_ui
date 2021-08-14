/* import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:myapp/constant/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateEvent {
  final String name;
  final String desc;
  final List<String> prefs;
  final String visibility;

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  CreateEvent(this.name, this.desc, this.prefs, this.visibility);

  Future<http.Response> createEvent() async {
    final SharedPreferences prefs = await _prefs;
    String? token = prefs.getString('Token');
    String bearerToken = 'Bearer $token';

    print('creating event called $name / $desc / $visibility /$eventUrl');
    final response = await http.post(eventUrl,
        headers: <String, String>{
          'ContentType': 'application/json; charset=UTF-8',
          'Authorization': '$bearerToken',
        },
        body: jsonEncode(<String, dynamic>{
          "name": name,
          "desc": desc,
          "musicPreference": prefs,
        }));
    print('response from create Event ${response.body}');
    return response;
  }
}
 */