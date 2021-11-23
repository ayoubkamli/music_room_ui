import 'package:shared_preferences/shared_preferences.dart';

class MyToken {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  setToken(String token) async {
    /// print('set token was called');
    SharedPreferences prefs = await _prefs;
    await prefs.setString("Token", token);
  }

  Future<String>? getToken() async {
    SharedPreferences prefs = await _prefs;
    return prefs.getString("Token").toString();
  }

  Future<String>? getBearerToken() async {
    String? token = await getToken();
    String bearerToken = 'Bearer: $token';
    return bearerToken;
  }

  clearToken() async {
    SharedPreferences prefs = await _prefs;
    prefs.clear();
  }
}
