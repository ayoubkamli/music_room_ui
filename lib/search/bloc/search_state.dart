import 'package:equatable/equatable.dart';
import 'package:myapp/auth/models/user.dart';
import 'package:myapp/events/models/tracks_model.dart';

abstract class SearchState extends Equatable {}

class SearchUninitialized extends SearchState {
  @override
  List<Object?> get props => [];
}

// ignore: must_be_immutable
class SearchTrackLoaded extends SearchState {
  TracksModel tracks;
  SearchTrackLoaded({
    required this.tracks,
  });
  @override
  List<Object?> get props => [];
}

// ignore: must_be_immutable
class SearchUserLoaded extends SearchState {
  List<User> users;
  SearchUserLoaded({
    required this.users,
  });
  @override
  List<Object?> get props => [];
}

class SearchError extends SearchState {
  @override
  List<Object?> get props => [];
}
