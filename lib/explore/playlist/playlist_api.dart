import 'package:http/http.dart' as http;
import 'package:myapp/constant/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetAllPlaylist {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<http.Response> fetchAllPlaylists() async {
    final SharedPreferences prefs = await _prefs;
    String? token = prefs.getString('Token');
    String? bearerToken = 'Bearer: $token';

    print('fetch all playlist was called');
    final response = await http.get(
      playlistUrl,
      headers: <String, String>{
        'ContentType': 'application/json; charset=UTF-8',
        'Aurhorization': '$bearerToken',
      },
    );
    print('data from play lists: ${response.body.toString()}');
    return response;
  }
}
