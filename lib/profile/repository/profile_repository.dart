import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:myapp/auth/models/user.dart';
import 'package:myapp/auth/utils/manage_token.dart';
import 'package:myapp/constant/constant.dart';
import 'package:myapp/profile/networking/profile_api.dart';

class ProfileRepository {
  late UserData userData = UserData();

  Future<http.Response> editeProfileForm(
    String username,
    String email,
    List<String> prefs,
  ) async {
    final response =
        await EditProfile().editProfileForm(username, email, prefs);
    return response;
  }

  // getUser() async {
  //   userData = await getUserProfile();
  //   print('email from edit profile \n ------ --- - ${userData.data!.email}');
  //   return userData;
  // }

  Future<UserData> getUserProfile() async {
    String? token = await MyToken().getToken();
    String? bearerToken = 'Bearer: $token';
    final response = await http.get(userDataUrl, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': '$bearerToken',
    });
    print('$bearerToken ++++ \n ${response.body.toString()}');
    var data = jsonDecode(response.body);

    print('res ========>>>>>>> ${data.toString()}');

    UserData res = UserData.fromJson(data);
    userData = res;

    return res;
  }
}
