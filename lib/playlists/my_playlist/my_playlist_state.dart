part of 'my_playlist_cubit.dart';

abstract class MyPlaylistState extends Equatable {
  const MyPlaylistState();

  @override
  List<PlaylistData> get props => [];
}

class MyPlaylistInitialState extends MyPlaylistState {}

class MyPlaylistsLoadingState extends MyPlaylistState {
  List<PlaylistData> get props => [];
}

class MyPlaylistsLoadedState extends MyPlaylistState {
  final List<PlaylistData> playlists;

  MyPlaylistsLoadedState(this.playlists);
  List<PlaylistData> get props => playlists;
}

class MyPlaylistErrorState extends MyPlaylistState {
  List<PlaylistData> get props => [];
}
