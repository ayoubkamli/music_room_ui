import 'package:http/http.dart' as http;
import 'package:myapp/constant/constant.dart';
import 'package:myapp/playlists/networking/playlist_api.dart';

class PlaylistRepository {
  Future<http.Response?> getAllPlaylists() async {
    try {
      final http.Response response =
          await PlaylistGet(playlistUrl).getRequest();
      if (response.statusCode == 200) {
        return response;
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<http.Response?> createPlaylist(String name, String description,
      List<String> playlistSelectedPrefList, String playlistStatus) async {
    Map<String, dynamic> data = {
      'name': name,
      'desc': description,
      'musicPreference': playlistSelectedPrefList,
      'visibility': playlistStatus
    };
    try {
      final response = await PlaylistPost(playlistUrl, data).postRequest();
      print('this is the response ${response.statusCode}');
      return response;
    } catch (e) {
      return null;
    }
  }

  Future<http.Response?> deletePlaylist(String id) async {
    final Uri url = Uri.parse('$playlistUrl/$id');
    try {
      final response = await PlaylistDelete(url).deleteRequest();
      if (response.statusCode == 200) {
        return response;
      } else {
        print('Deleted playlist repo went wrong');
        return null;
      }
    } catch (e) {
      print('Deleted playlist repo went wrong catch');
      return null;
    }
  }

  Future<http.Response?> getMyPlaylist() async {
    try {
      final http.Response response =
          await PlaylistGet(myPlaylistUrl).getRequest();
      if (response.statusCode == 200) {
        return response;
      } else {
        print('response from myplaylist not !200' + response.body.toString());
        return null;
      }
    } catch (e) {
      print('soe thing went wrong catch myplaylist');
      return null;
    }
  }

  Future<http.Response?> getOnePlaylist(String id) async {
    final url = Uri.parse('$playlistUrl/$id');
    try {
      final http.Response response = await PlaylistGet(url).getRequest();
      print('response from getOnePlaylist ${response.statusCode} ');
      if (response.statusCode == 200) {
        print(response.body.toString());

        return response;
      } else {
        print('something went wrong from get one playlist');
        return null;
      }
    } catch (e) {
      print('somr thing went wrong from cach one play list');
      return null;
    }
  }

  Future<http.Response?> editPlaylist(String id, String name, String desc,
      List<String> musicPreference, String visibility) async {
    // is visbility or visibility
    Map<String, dynamic> data = {
      'name': '$name',
      'desc': '$desc',
      'musicPreference': musicPreference,
      'visbility': '$visibility'
    };
    print('this is the palylist id $id');
    final Uri url = Uri.parse('$playlistUrl/$id');
    print('url...  $url');
    try {
      final http.Response response = await PlaylistPut(url, data).putRequest();
      print(
          'this the response from the plalylist repository ${response.statusCode}');
      if (response.statusCode == 200) {
        return response;
      } else {
        print('some thnign went wrong from editPlaylist');
        return null;
      }
    } catch (e) {
      print('some thing catched in edit playlist');
      return null;
    }
  }

  Future<http.Response?> removeTrackPlaylist(
      String playlistId, String trackId) async {
    final Uri url = Uri.parse('$playlistUrl/$playlistId/track');
    try {
      final http.Response response =
          await PlaylistDeleteWithBody(url, trackId).deleteRequest();
      if (response.statusCode == 200) {
        return response;
      } else {
        print('some thing went wrong from delete track');
        return null;
      }
    } catch (e) {
      print('some thing catch in the remove track playlist');
      return null;
    }
  }

  Future<http.Response?> addTrackPlaylist(
      String playlistId, String trackId) async {
    Map<String, dynamic> source = {'userId': trackId};
    final Uri url = Uri.parse('$playlistUrl/$playlistId/track');
    try {
      final http.Response response =
          await PlaylistPost(url, source).postRequest();
      if (response.statusCode == 200) {
        return response;
      } else {
        print('some thing went wrong in add track to playlilst ');
        return null;
      }
    } catch (e) {
      print('some thing catch in add track to playlist');
      return null;
    }
  }

  Future<http.Response?> addUserPlaylist(
      String playlistId, String userId) async {
    Map<String, dynamic> source = {'userId': userId};
    final Uri url = Uri.parse('$playlistUrl/$playlistId/invite');
    try {
      final http.Response response =
          await PlaylistPost(url, source).postRequest();
      if (response.statusCode == 200) {
        return response;
      } else {
        print('some thing went wrong in add track to playlilst ');
        return null;
      }
    } catch (e) {
      print('some thing catch in add track to playlist');
      return null;
    }
  }

  Future<String> getPlaylistPicture(String? pictureName) async {
    if (pictureName == null) {
      return '';
    }
    final Uri url = Uri.parse('$playlistUrl/photos/$pictureName');
    try {
      final http.Response response = await PlaylistGet(url).getRequest();
      if (response.statusCode == 200) {
        return response.body.toString();
      } else {
        print('Some thing went wrong in getPlaylistPicture');
        return '';
      }
    } catch (e) {
      print('some thing catched in get playlist picture');
      return '';
    }
  }
}
