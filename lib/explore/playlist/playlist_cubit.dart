import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/explore/playlist/playlist_repository.dart';
import 'package:myapp/explore/playlist/playlist_state.dart';

class PlaylistCubit extends Cubit<PlaylistState> {
  final PlaylistRepository playlistRepository;

  PlaylistCubit(this.playlistRepository) : super(InitialState()) {
    getAll();
  }
  Future<void> getAll() async {
    try {
      emit(LoadingState());
      final allPlaylist = await playlistRepository.getAllplaylists();
      if (allPlaylist.statusCode == 200) {
        final data = jsonDecode(allPlaylist.body);
        final datalist = data['data'];
        emit(LoadedState(datalist));
      } else {
        throw Error();
      }
    } catch (e) {
      emit(ErrorState());
    }
  }
}
