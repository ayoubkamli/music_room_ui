import 'package:shared_preferences/shared_preferences.dart';

class MyToken {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  setToken(String token) async {
    /// print('set token was called');
    SharedPreferences prefs = await _prefs;
    await prefs.setString("Token", token);
  }

  getToken() async {
    SharedPreferences prefs = await _prefs;
    return prefs.getString("Token").toString();
  }
}
