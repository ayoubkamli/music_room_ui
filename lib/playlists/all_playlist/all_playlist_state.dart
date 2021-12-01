part of 'all_playlist_cubit.dart';

abstract class AllPlaylistState extends Equatable {
  const AllPlaylistState();

  @override
  List<PlaylistData> get props => [];
}

class AllPlaylistInitialState extends AllPlaylistState {}

class AllPlaylistsLoadingState extends AllPlaylistState {
  List<PlaylistData> get props => [];
}

class AllPlaylistLoadedState extends AllPlaylistState {
  final List<PlaylistData> playlists;

  AllPlaylistLoadedState(this.playlists);
  List<PlaylistData> get props => playlists;
}

class AllPlaylistErrorState extends AllPlaylistState {
  List<PlaylistData> get props => [];
}
