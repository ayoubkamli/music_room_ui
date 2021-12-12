import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/auth/models/user.dart';
import 'package:myapp/search/bloc/search_event.dart';
import 'package:myapp/search/bloc/search_repository.dart';
import 'package:myapp/search/bloc/search_state.dart';
import 'package:myapp/events/models/tracks_model.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchRepository searchRepository;

  SearchBloc({required this.searchRepository}) : super(SearchUninitialized());

  SearchState get initialState => SearchUninitialized();

  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is SearchTrack) {
      yield SearchUninitialized();
      try {
        http.Response response =
            await SearchRepositoryTracks().getTracks(event.query);
        print('------ track bloc ---- \n ${response.body.toString()}');
        TracksModel tracks = TracksModel.fromJson(jsonDecode(response.body));
        print(
            'artisste name ------ \n ${tracks.data[1].artists[0].name.toString()}');

        yield SearchTrackLoaded(tracks: tracks);
      } catch (e) {
        yield SearchError();
      }
    }
    if (event is SearchUser) {
      yield SearchUninitialized();
      try {
        http.Response response =
            await SearchRepositoryUser().getUsers(event.query);
        // print('------ user bloc ---- \n ${response.body.toString()}');
        List usersList = json.decode(response.body)['data'] as List;
        print('${usersList.length}');
        if (response.statusCode == 200) {
          List<User>? users =
              usersList.map((user) => User.fromJson(user)).toList();
          print('users ********  ${users.length}');
          yield SearchUserLoaded(users: users);
        }
      } catch (e) {
        yield SearchError();
      }
    }
  }
}
