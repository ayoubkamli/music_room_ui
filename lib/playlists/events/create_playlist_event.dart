abstract class CreatePlaylistEvent {}

class CreatePlaylistNameChanged extends CreatePlaylistEvent {
  final String? name;

  CreatePlaylistNameChanged({this.name});
}

class CreatePlaylistDescriptionChanged extends CreatePlaylistEvent {
  final String? description;

  CreatePlaylistDescriptionChanged({this.description});
}

class CreatePlaylistPrefChanged extends CreatePlaylistEvent {
  final List<String>? prefs;

  CreatePlaylistPrefChanged({this.prefs});
}

class CreatePlaylistStatusChanged extends CreatePlaylistEvent {
  final String? status;

  CreatePlaylistStatusChanged({this.status});
}

class CreatePlaylistUploadPhoto extends CreatePlaylistEvent {
  final String? data;

  CreatePlaylistUploadPhoto(this.data);
}

class CreatePlaylistSubmitted extends CreatePlaylistEvent {}
