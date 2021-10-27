import 'package:http/http.dart' as http;
import 'package:myapp/constant/constant.dart';

abstract class SearchRepository {
  Future<http.Response> getTracks();
}

class SearchRepositoryTracks extends SearchRepository {
  @override
  Future<http.Response> getTracks() async {
    http.Response response = await http.get(searchTracksUrl);
    if (response.statusCode == 200) {
      // dynamic data = json.decode(response.body);
      return response;
    } else {
      throw Exception('Faild request from search repo');
    }
  }
}
