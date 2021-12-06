import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:myapp/formStatus/form_submission_status.dart';
import 'package:myapp/playlists/bloc/edit_playlist.dart/edit_playlist_event.dart';
import 'package:myapp/playlists/bloc/edit_playlist.dart/edit_playlist_state.dart';
import 'package:myapp/playlists/repositories/playlist_repository.dart';

class EditPlaylistBloc extends Bloc<EditPlaylistEvent, EditPlaylistState> {
  final PlaylistRepository repository;

  EditPlaylistBloc(this.repository) : super(EditPlaylistState());

  @override
  Stream<EditPlaylistState> mapEventToState(EditPlaylistEvent event) async* {
    if (event is EditPlaylistIdChanged) {
      yield state.copyWith(id: event.id);
    }
    if (event is EditPlaylistNameChanged) {
      print('vent name is: ${event.name}');
      yield state.copyWith(name: event.name);
    } else if (event is EditPlaylistDescriptionChanged) {
      yield state.copyWith(description: event.description);
    } else if (event is EditPlaylistStatusChanged) {
      yield state.copyWith(visibilityStatus: event.visiblity);
    } else if (event is EditPlaylistPrefChanged) {
      yield state.copyWith(selectedPrefList: event.prefs);
    } else if (event is EditPlaylistSubmitted) {
      try {
        final Response? response = await repository.editPlaylist(
            state.id!,
            state.name,
            state.description,
            state.selectedPrefList,
            state.visibilityStatus);

        if (response != null && response.statusCode == 200) {
          EditPlaylistUploadPhotoChanged(jsonDecode(response.body).toString());
          yield state.copyWith(data: state.id);
          yield state.copyWith(formStatus: SubmissionSuccess());
          yield state.copyWith(formStatus: InitialFormStatus());
        } else {
          print('Somthing went wrong in edit playlist else bloc');
          yield state.copyWith(
              formStatus: SubmissionFailed('someThings went wrong try again'));
          yield state.copyWith(formStatus: InitialFormStatus());
        }
      } catch (e) {
        print('Some thing get catched in the edit playlist bloc');
        yield state.copyWith(
            formStatus: SubmissionFailed('someThings went wrong try again'));
        yield state.copyWith(formStatus: InitialFormStatus());
      }
    }
  }
}
