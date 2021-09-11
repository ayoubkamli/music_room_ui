import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:myapp/constant/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreatePlaylist {
  final String name;
  final String description;
  final List<String> pref;
  final String visibility;

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  CreatePlaylist(this.name, this.description, this.pref, this.visibility);

  Future<http.Response> createPlaylist() async {
    final SharedPreferences prefs = await _prefs;
    String? token = prefs.getString('Token');
    String bearerToken = 'Bearer $token';

    final response = await http.post(playlistUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': '$bearerToken',
        },
        body: jsonEncode(<String, dynamic>{
          "name": name,
          "desc": description,
          "musicPreference": pref,
          "visibility": visibility,
        }));
    print('response from create Event ${response.body}');
    return response;
  }
}
