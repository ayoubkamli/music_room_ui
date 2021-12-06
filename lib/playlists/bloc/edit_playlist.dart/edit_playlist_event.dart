abstract class EditPlaylistEvent {}

class EditPlaylistNameChanged extends EditPlaylistEvent {
  final String? name;

  EditPlaylistNameChanged({this.name});
}

class EditPlaylistIdChanged extends EditPlaylistEvent {
  final String? id;

  EditPlaylistIdChanged({this.id});
}

class EditPlaylistDescriptionChanged extends EditPlaylistEvent {
  final String? description;

  EditPlaylistDescriptionChanged({this.description});
}

class EditPlaylistPrefChanged extends EditPlaylistEvent {
  final List<String>? prefs;

  EditPlaylistPrefChanged({this.prefs});
}

class EditPlaylistStatusChanged extends EditPlaylistEvent {
  final String? visiblity;

  EditPlaylistStatusChanged({this.visiblity});
}

class EditPlaylistUploadPhotoChanged extends EditPlaylistEvent {
  final String? data;

  EditPlaylistUploadPhotoChanged(this.data);
}

class EditPlaylistSubmitted extends EditPlaylistEvent {}
