import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:myapp/auth/utils/manage_token.dart';
import 'package:myapp/utils/http_headers.dart';

class PlaylistPost {
  final Uri url;
  final Map<String, dynamic> source;

  PlaylistPost(this.url, this.source);

  Future<http.Response> postRequest() async {
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
    print('$url\n $headers ');

    final response = await http.get(
      url,
      headers: headers,
    );
    return response;
  }
}

class PlaylistDelete {
  final Uri url;

  PlaylistDelete(this.url);

  Future<http.Response> deleteRequest() async {
    Map<String, String> headers = await MyHeader().getHeaders();

    final response = await http.delete(url, headers: headers);
    return response;
  }
}

class PlaylistDeleteWithBody {
  final Uri url;
  final String trackId;

  PlaylistDeleteWithBody(this.url, this.trackId);

  Future<http.Response> deleteRequest() async {
    Map<String, dynamic> body = {'trackId': '$trackId'};
    Map<String, String> headers = await MyHeader().getHeaders();

    final response = await http.delete(url, headers: headers, body: body);
    return response;
  }
}

class PlaylistPut {
  final Uri url;
  final Map<String, dynamic> source;

  PlaylistPut(this.url, this.source);

  Future<http.Response> putRequest() async {
    print('this is the source :  ${source.toString()}');
    print('this is the url :  ${url.toString()}');
    Map<String, String> header = await MyHeader().getHeaders();
    print(header.toString());

    final response =
        await http.put(url, headers: header, body: jsonEncode(source));

    print('response => ${response.statusCode}');
    return response;
  }
}

class PlaylistPostTrack {
  final Uri url;
  final String source;

  PlaylistPostTrack(this.url, this.source);

  Future<http.Response> postRequest() async {
    Map<String, String> headers = await MyHeader().getHeaders();

    final response = await http.post(url, headers: headers, body: {
      "trackId": "16EMONl2vH3rt9f4ehTG8g",
    });
    return response;
  }
}

class AddTrackToPlaylist {
  Future<http.Response> addTrackToPlaylist(url, trackId) async {
    String? token = await MyToken().getToken();
    String? bearerToken = 'Bearer: $token';

    final response = await http.post(url, headers: <String, String>{
      'ContentType': 'application/json; charset=UTF-8',
      'Authorization': '$bearerToken',
    }, body: {
      "trackId": trackId.toString()
    });

    // print('this is the response body from add track to event api below');
    // print(response.body.toString());

    print(response.body.toString());

    return response;
  }
}
