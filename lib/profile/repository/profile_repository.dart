import 'package:http/http.dart' as http;
import 'package:myapp/profile/networking/profile_api.dart';

class ProfileRepository {
  Future<http.Response> editeProfile(
    String username,
    String email,
    List<String> prefs,
  ) async {
    final response = await EditProfile(username, email, prefs).editProfile();
    return response;
  }
}
