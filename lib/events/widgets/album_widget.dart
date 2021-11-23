import 'package:flutter/material.dart';
import 'package:myapp/events/models/event_model.dart';
import 'package:myapp/events/screens/track_screen.dart';

Future<dynamic> eventTracks(Map<String, dynamic> data, context) {
  print(data);
  print('++++++++++');

  //SongModel item = SongModel.fromJson(data);

  AlbumModelOld item = AlbumModelOld.fromJson(data);

  print("item  $item");
  return Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => TrackEventView(
        data: item,
      ),
    ),
  );
}
