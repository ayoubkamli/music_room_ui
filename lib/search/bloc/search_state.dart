import 'package:equatable/equatable.dart';

abstract class SearchState extends Equatable {}

class SearchUninitialized extends SearchState {
  @override
  List<Object?> get props => [];
}

// ignore: must_be_immutable
class SearchLoaded extends SearchState {
  List<dynamic> tracks;
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
