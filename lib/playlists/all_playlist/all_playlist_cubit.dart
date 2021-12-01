import 'dart:convert';

import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:myapp/playlists/models/playlist_model.dart';
import 'package:myapp/playlists/repositories/playlist_repository.dart';

part 'all_playlist_state.dart';

class AllPlaylistCubit extends Cubit<AllPlaylistState> {
  final PlaylistRepository playlistRepository;

  AllPlaylistCubit({required this.playlistRepository})
      : super(AllPlaylistInitialState()) {
    getAllPlaylist();
  }

  Future<void> getAllPlaylist() async {
    try {
      emit(AllPlaylistsLoadingState());
      final Response? playlists = await playlistRepository.getAllPlaylists();
      print('44444444444444444444444444444444444');
      // print('playlists!.body.toString()' + playlists!.body.toString());
      if (playlists != null) {
        final data = jsonDecode(playlists.body);
        final List<PlaylistData> allPlaylist = [];
        print('datattttttaaaaa: ${data['data']}');
        List.generate(data['data'].length, (index) {
          print('index: $index data: ${data['data'][index]}');

          allPlaylist.add(PlaylistData.fromJson(data['data'][index]));
        });
        print(" {allPlaylist.first} ${allPlaylist.first}");
        emit(AllPlaylistLoadedState(allPlaylist));
      } else {
        print('all_playlist_cubit ------> response is null');
        emit(AllPlaylistErrorState());
      }
    } catch (e) {
      print('all_playlist_cubit ------> catch some error');
      emit(AllPlaylistErrorState());
    }
  }
}
