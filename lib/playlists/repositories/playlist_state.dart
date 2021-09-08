abstract class PlaylistState {
  set allPlaylists(List<dynamic> allPlaylists) {}
}

class PlaylistInitialState extends PlaylistState {
  List<dynamic> get props => [];
}

class PlaylistLoadingState extends PlaylistState {
  List<dynamic> get props => [];
}

class PlaylistLoadedState extends PlaylistState {
  final List<dynamic> allPlaylists;

  PlaylistLoadedState(this.allPlaylists);
  List<dynamic> get props => [allPlaylists];
}

class PlaylistErrorState extends PlaylistState {
  List<dynamic> get props => [];
}
