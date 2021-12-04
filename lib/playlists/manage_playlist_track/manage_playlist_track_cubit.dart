import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/playlists/manage_playlist_track/manage_playlist_track_state.dart';
import 'package:myapp/playlists/repositories/playlist_repository.dart';

class PlaylistTrackCubit extends Cubit<PlaylistTrackState> {
  PlaylistTrackCubit() : super(InitialPlaylistTrackState());

  static PlaylistTrackCubit get(BuildContext context) {
    return BlocProvider.of(context);
  }

  String playlistId = '';

  Future<bool> addPlaylistTrack(String playlistId, String trackId) async {
    http.Response? response =
        await PlaylistRepository().addTrackPlaylist(playlistId, trackId);
    if (response != null && response.statusCode == 200) {
      return Future<bool>.value(true);
    }
    return Future<bool>.value(false);
  }

  Future<void> removePlaylistTrack(String playlistId, String trackId) async {
    http.Response? response =
        await PlaylistRepository().removeTrackPlaylist(playlistId, trackId);
    if (response != null && response.statusCode == 200) {
      print('track deleted with success');
    } else {
      print('Delete track complete with failure');
    }
  }
}
