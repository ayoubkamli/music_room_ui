import 'package:http/http.dart' as http;
import 'package:myapp/explore/playlist/playlist_api.dart';

class PlaylistRepository {
  Future<http.Response> getAllplaylists() async {
    final response = await GetAllPlaylist().fetchAllPlaylists();
    return response;
  }
}
