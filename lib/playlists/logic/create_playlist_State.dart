import 'package:myapp/auth/utils/MyValidator.dart';
import 'package:myapp/formStatus/form_submission_status.dart';

class CreatePlaylistState {
  final String name;
  bool get isPlaylistNameValid => MyInputValidator().isEventNameValid(name);

  final String description;
  bool get isPlaylistDescriptionValid =>
      MyInputValidator().isEventdescriptionValid(description);

  final String playlistStatus;

  final List<String> playlistSelectedPrefList;
  bool get isPrefListValid =>
      MyInputValidator().isPrefListValid(playlistSelectedPrefList);

  final FormSubmissionStatus playlistFormStatus;

  String? data;

  CreatePlaylistState({
    this.name = '',
    this.description = '',
    this.playlistSelectedPrefList = const [],
    this.playlistStatus = 'public',
    this.playlistFormStatus = const InitialFormStatus(),
    this.data,
  });

  CreatePlaylistState copyWith({
    String? name,
    String? description,
    String? playlistStatus,
    List<String>? playlistSelectedPrefList,
    FormSubmissionStatus? playlistFormStatus,
    String? data,
  }) {
    return CreatePlaylistState(
      name: name ?? this.name,
      description: description ?? this.description,
      playlistStatus: playlistStatus ?? this.playlistStatus,
      playlistSelectedPrefList:
          playlistSelectedPrefList ?? this.playlistSelectedPrefList,
      playlistFormStatus: playlistFormStatus ?? this.playlistFormStatus,
      data: data ?? this.data,
    );
  }
}
