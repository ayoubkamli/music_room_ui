import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {}

// ignore: must_be_immutable
class SearchTrack extends SearchEvent {
  String query;
  SearchTrack({
    required this.query,
  });

  @override
  List<Object?> get props => [];
}

// ignore: must_be_immutable
class SearchUser extends SearchEvent {
  String query;
  SearchUser({
    required this.query,
  });

  @override
  List<Object?> get props => [];
}
