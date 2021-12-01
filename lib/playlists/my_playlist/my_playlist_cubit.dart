import 'dart:convert';

import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:myapp/playlists/models/playlist_model.dart';
import 'package:myapp/playlists/repositories/playlist_repository.dart';

part 'my_playlist_state.dart';

class MyPlaylistCubit extends Cubit<MyPlaylistState> {
  final PlaylistRepository playlistRepository;

  MyPlaylistCubit({required this.playlistRepository})
      : super(MyPlaylistInitialState()) {
    getMyPlaylist();
  }

  Future<void> getMyPlaylist() async {
    try {
      emit(MyPlaylistsLoadingState());
      final Response? playlists = await playlistRepository.getMyPlaylist();
      print('5555555555555555555555555555');
      // print('playlists!.body.toString()' + playlists!.body.toString());
      if (playlists != null) {
        final data = jsonDecode(playlists.body);
        final List<PlaylistData> myPlaylist = [];

        print(
            'datattttttaaaaa: ${data['data']} data length: ${data["data"].length}');
        List.generate(data['data'].length, (index) {
          print('index: $index data: ${data['data'][index]}');

          myPlaylist.add(PlaylistData.fromJson(data['data'][index]));
        });
        emit(MyPlaylistsLoadedState(myPlaylist));
      } else {
        print('all_playlist_cubit ------> response is null');
        emit(MyPlaylistErrorState());
      }
    } catch (e) {
      print('all_playlist_cubit ------> catch some error');
      emit(MyPlaylistErrorState());
    }
  }
}
