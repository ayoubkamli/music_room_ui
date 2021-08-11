class EventModel {
  String name;
  String desc;
  List<dynamic> musicPreference;
  String visibility;

  EventModel(
      {required this.name,
      required this.desc,
      required this.musicPreference,
      required this.visibility});

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
        name: json['name'],
        desc: json['desc'],
        musicPreference: json['musicPreference'],
        visibility: json['visibility']);
  }
}
