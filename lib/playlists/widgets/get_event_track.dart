import 'package:flutter/material.dart';
import 'package:myapp/playlists/models/playlist_model.dart';
import 'package:myapp/playlists/widgets/playlist_player.dart';

Future<dynamic> getEventTracks(PlaylistData data, context) {
  print(data);
  print('++++++++++');

  // PlaylistData item = PlaylistData.fromJson(data);

  print("item  ${data.desc}");
  return Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => PlaylistPlayer(
        data: data,
      ),
    ),
  );
}
