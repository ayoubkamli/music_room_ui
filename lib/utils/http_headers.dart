import 'package:myapp/auth/utils/manage_token.dart';

class MyHeader {
  getHeaders() async {
    String? bearerToken = await MyToken().getBearerToken();

    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': '$bearerToken',
    };
    return headers;
  }
}
