import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {}

// ignore: must_be_immutable
class Search extends SearchEvent {
  String query;
  Search({
    required this.query,
  });

  @override
  List<Object?> get props => [];

  
}
