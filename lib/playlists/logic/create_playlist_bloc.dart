import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'package:myapp/formStatus/form_submission_status.dart';
import 'package:myapp/playlists/logic/create_playlist_State.dart';
import 'package:myapp/playlists/events/create_playlist_event.dart';
import 'package:myapp/playlists/repositories/playlist_repository.dart';

class CreatePlaylistBloc
    extends Bloc<CreatePlaylistEvent, CreatePlaylistState> {
  final PlaylistRepository repository;
  //final PlaylistCubit playlistCubit;

  // CreatePlaylistBloc(this.repository, this.playlistCubit)
  //     : super(CreatePlaylistState());
  CreatePlaylistBloc(this.repository) : super(CreatePlaylistState());

  @override
  Stream<CreatePlaylistState> mapEventToState(
      CreatePlaylistEvent event) async* {
    if (event is CreatePlaylistNameChanged) {
      yield state.copyWith(name: event.name);
    } else if (event is CreatePlaylistDescriptionChanged) {
      yield state.copyWith(description: event.description);
    } else if (event is CreatePlaylistStatusChanged) {
      yield state.copyWith(playlistStatus: event.status);
    } else if (event is CreatePlaylistPrefChanged) {
      yield state.copyWith(playlistSelectedPrefList: event.prefs);
    } else if (event is CreatePlaylistSubmitted) {
      yield state.copyWith(playlistFormStatus: FormSubmitting());
      try {
        final http.Response? response = await repository.createPlaylist(
          state.name,
          state.description,
          state.playlistSelectedPrefList,
          state.playlistStatus,
        );
        print('tttttttt' + response!.body.toString());
        if (response.statusCode == 200) {
          state.copyWith(
            name: '',
            description: '',
            playlistSelectedPrefList: [],
            playlistStatus: '',
          );
          print('starttttttttttttttt');
          print(jsonDecode(response.body.toString()));
          var test = jsonDecode(response.body.toString());

          if (test['success'] == true) {
            print(test['data']['_id']);
          }
          yield state.copyWith(data: test['data']['_id']);
          print('thissssssssss');
          yield state.copyWith(playlistFormStatus: SubmissionSuccess());
          yield state.copyWith(playlistFormStatus: InitialFormStatus());
          print('playlist response code ${response.statusCode}');
        } else {
          yield state.copyWith(
              playlistFormStatus:
                  SubmissionFailed('Invalide information try again'));
          print('some thing went wrong in create playlist bloc');
        }
      } catch (e) {
        print('some thing went wrong in create playlist bloc catch(e)');
        yield state.copyWith(
            playlistFormStatus: SubmissionFailed('Some things went wrong'));
        yield state.copyWith(playlistFormStatus: InitialFormStatus());
      }
    }
  }
}
