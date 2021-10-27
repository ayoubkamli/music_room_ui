import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/search/bloc/search_event.dart';
import 'package:myapp/search/bloc/search_repository.dart';
import 'package:myapp/search/bloc/search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchRepository searchRepository;

  SearchBloc({required this.searchRepository}) : super(SearchUninitialized());

  // SearchState get initialState => SearchUninitialized();

  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is Search) {
      yield SearchUninitialized();
      try {
        http.Response response = await searchRepository.getTracks();
        yield SearchLoaded(tracks: jsonDecode(response.body));
      } catch (e) {
        yield SearchError();
      }
    }
  }
}
