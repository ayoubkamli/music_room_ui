import 'package:http/http.dart' as http;
import 'package:myapp/constant/constant.dart';

abstract class SearchRepository {
  Future<http.Response> getTracks(String query);
}

class SearchRepositoryTracks extends SearchRepository {
  @override
  Future<http.Response> getTracks(String query) async {
    String url = '$searchTrackUrl$query';
    print(url);
    http.Response response = await http.get(Uri.parse('$url'));
    print(response.statusCode.toString());
    if (response.statusCode == 200) {
      // dynamic data = json.decode(response.body);
      return response;
    } else {
      throw Exception('Faild request from search repo');
    }
  }
}
