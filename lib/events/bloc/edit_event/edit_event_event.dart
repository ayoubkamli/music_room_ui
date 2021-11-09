abstract class EditEventEvent {}

class EditEventNameChanged extends EditEventEvent {
  final String? name;

  EditEventNameChanged({this.name});
}

class EditEventIdChanged extends EditEventEvent {
  final String? id;

  EditEventIdChanged({this.id});
}

class EditEventDescriptionChanged extends EditEventEvent {
  final String? description;

  EditEventDescriptionChanged({this.description});
}

class EditEventPrefChanged extends EditEventEvent {
  final List<String>? prefs;

  EditEventPrefChanged({this.prefs});
}

class EditEventStatusChanged extends EditEventEvent {
  final String? status;

  EditEventStatusChanged({this.status});
}

class EditEventUploadphoto extends EditEventEvent {
  final String? data;

  EditEventUploadphoto(this.data);
}

class EditEventSubmitted extends EditEventEvent {}
