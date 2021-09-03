abstract class PlaylistState {
  set playlist(List<dynamic> playlist) {}
}

class InitialState extends PlaylistState {
  List<dynamic> get props => [];
}

class LoadingState extends PlaylistState {
  List<dynamic> get props => [];
}

class LoadedState extends PlaylistState {
  final List<dynamic> allPlaylists;

  LoadedState(this.allPlaylists);
  List<dynamic> get props => [allPlaylists];
}

class ErrorState extends PlaylistState {
  List<dynamic> get props => [];
}
