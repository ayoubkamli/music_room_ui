class EventModel {
  String name;
  String desc;
  List<dynamic> musicPreference;
  String visibility;
  String imgUrl;

  EventModel(
      {required this.name,
      required this.desc,
      required this.musicPreference,
      required this.visibility,
      required this.imgUrl});

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      name: json['name'],
      desc: json['desc'],
      musicPreference: json['musicPreference'],
      visibility: json['visibility'],
      imgUrl: json['img'] ??
          'https://i.picsum.photos/id/629/536/354.jpg?hmac=NWta_CV-ruzeQyb9CvcPbGAmrmMV66H8m9A2d_8rdpI',
    );
  }
}
