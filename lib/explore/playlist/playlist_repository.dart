import 'package:http/http.dart' as http;
import 'package:myapp/constant/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlaylistRepository {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<http.Response> getAllPlaylists() async {
    final SharedPreferences prefs = await _prefs;
    String? token = prefs.getString('Token');
    String? bearerToken = 'Bearer: $token';

    print('fetch all event was called');

    final response = await http.get(
      playlistUrl,
      headers: <String, String>{
        'ContentType': 'application/json; charset=UTF-8',
        'Authorization': '$bearerToken',
      },
    );
    print('response to string : ${response.body.toString()}');
    /*  print(
        'response of fetch event body: ${response.body} code: ${response.statusCode}'); */
    return response;
  }
}
