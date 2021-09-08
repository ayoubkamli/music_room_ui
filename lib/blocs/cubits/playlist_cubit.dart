import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/blocs/resources/playlist_repository.dart';
import 'package:myapp/blocs/states/playlist_state.dart';

class PlaylistCubit extends Cubit<PlaylistState> {
  final PlaylistRepository playlistRepository;

  PlaylistCubit({required this.playlistRepository})
      : super(PlaylistInitialState()) {
    getAllPlaylists();
  }

  Future<void> getAllPlaylists() async {
    try {
      emit(PlaylistLoadingState());
      final playlists = await playlistRepository.getAllPlaylists();
      if (playlists.statusCode == 200) {
        final data = jsonDecode(playlists.body);
        final datalist = data['data'];
        emit(PlaylistLoadedState(datalist));
      } else {
        throw Error();
      }
    } catch (e) {
      emit(PlaylistErrorState());
    }
  }
}
