import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/formStatus/form_submission_status.dart';
import 'package:myapp/playlists/logic/create_playlist_State.dart';
import 'package:myapp/playlists/logic/playlist_cubit.dart';
import 'package:myapp/playlists/events/create_playlist_event.dart';
import 'package:myapp/playlists/repositories/playlist_repository.dart';

class CreatePlaylistBloc
    extends Bloc<CreatePlaylistEvent, CreatePlaylistState> {
  final PlaylistRepository repository;
  final PlaylistCubit playlistCubit;

  CreatePlaylistBloc(this.repository, this.playlistCubit)
      : super(CreatePlaylistState());

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
        final response = await repository.createPlaylist(
          state.name,
          state.description,
          state.playlistSelectedPrefList,
          state.playlistStatus,
        );
        if (response.statusCode == 200) {
          print(response);
          state.copyWith(
            name: '',
            description: '',
            playlistSelectedPrefList: [],
            playlistStatus: '',
          );
          yield state.copyWith(playlistFormStatus: SubmissionSuccess());
          yield state.copyWith(playlistFormStatus: InitialFormStatus());
        } else {
          throw Exception();
        }
        print('playlist response code ${response.statusCode}');
      } catch (e) {
        yield state.copyWith(
            playlistFormStatus: SubmissionFailed('Some things went wrong'));
        yield state.copyWith(playlistFormStatus: InitialFormStatus());
      }
    }
  }
}
