import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:myapp/utils/http_headers.dart';

// class CreatePlaylist {
//   final String name;
//   final String description;
//   final List<String> pref;
//   final String visibility;

//   CreatePlaylist(this.name, this.description, this.pref, this.visibility);

//   Future<http.Response> createPlaylist() async {
//     Map<String, String> headers = await MyHeader().getHeaders();

//     final response = await http.post(playlistUrl,
//         headers: headers,
//         body: jsonEncode(<String, dynamic>{
//           "name": name,
//           "desc": description,
//           "musicPreference": pref,
//           "visibility": visibility,
//         }));
//     print('response from create Event ${response.body}');
//     return response;
//   }
// }

class PlaylistPost {
  final Uri url;
  final Map<String, dynamic> source;

  PlaylistPost(this.url, this.source);

  Future<http.Response> createPlaylist() async {
    Map<String, String> headers = await MyHeader().getHeaders();

    final response =
        await http.post(url, headers: headers, body: jsonEncode(source));
    return response;
  }
}

class PlaylistGet {
  final Uri url;

  PlaylistGet(this.url);

  Future<http.Response> getRequest() async {
    Map<String, String> headers = await MyHeader().getHeaders();

    final response = await http.get(
      url,
      headers: headers,
    );
    return response;
  }
}
