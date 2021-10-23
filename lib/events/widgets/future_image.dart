import 'package:myapp/constant/constant.dart';
import 'package:http/http.dart' as http;

Future<String> getImageUrl(url) async {
  try {
    final http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      print('get image url 2000002222');
      return url;
    }
  } catch (e) {
    print('get image url 11111');
    return imageUrl;
  }
  print('get image url 00000');
  return imageUrl;
}
