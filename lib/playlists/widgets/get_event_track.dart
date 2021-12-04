import 'package:flutter/material.dart';
import 'package:myapp/playlists/models/playlist_model.dart';
import 'package:myapp/playlists/screens/playlist_track_view.dart';

Future<dynamic> getEventTracks(PlaylistData data, BuildContext context) async {
  print(data);
  print('++++++++++');

  // PlaylistData item = PlaylistData.fromJson(data);

  print("item  ${data.desc}");

  return Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => PlaylistTrackView(
        playlistId: data.id!,
      ),
    ),
  );
}
