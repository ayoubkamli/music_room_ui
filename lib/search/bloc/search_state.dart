import 'package:equatable/equatable.dart';
import 'package:myapp/events/models/tracks_model.dart';

abstract class SearchState extends Equatable {}

class SearchUninitialized extends SearchState {
  @override
  List<Object?> get props => [];
}

// ignore: must_be_immutable
class SearchLoaded extends SearchState {
  TracksModel tracks;
  SearchLoaded({
    required this.tracks,
  });
  @override
  List<Object?> get props => [];
}

class SearchError extends SearchState {
  @override
  List<Object?> get props => [];
}
