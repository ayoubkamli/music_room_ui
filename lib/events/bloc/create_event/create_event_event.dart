abstract class CreateEventEvent {}

class CreateEventNameChanged extends CreateEventEvent {
  final String? name;

  CreateEventNameChanged({this.name});
}

class CreateEventDescriptionChanged extends CreateEventEvent {
  final String? description;

  CreateEventDescriptionChanged({this.description});
}

class CreateEventPrefChanged extends CreateEventEvent {
  final List<String>? prefs;

  CreateEventPrefChanged({this.prefs});
}

class CreateEventStatusChanged extends CreateEventEvent {
  final String? status;

  CreateEventStatusChanged({this.status});
}

class CreateEventUploadphoto extends CreateEventEvent {
  final String? data;

  CreateEventUploadphoto(this.data);
}

class CreateEventSubmitted extends CreateEventEvent {}
