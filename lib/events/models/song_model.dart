class AlbumModel {
  AlbumModel({
    required this.success,
    required this.data,
  });
  late final bool success;
  late final Data data;

  AlbumModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['data'] = data.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.subscribes,
    required this.unsubscribes,
    required this.musicPreference,
    required this.invitedUsers,
    this.trackUrl,
    required this.visibility,
    required this.id,
    required this.name,
    required this.desc,
    required this.chatRoom,
    required this.ownerId,
    required this.playlist,
    required this.image,
  });
  late final List<dynamic> subscribes;
  late final List<dynamic> unsubscribes;
  late final List<String> musicPreference;
  late final List<dynamic> invitedUsers;
  late final Null trackUrl;
  late final String visibility;
  late final String id;
  late final String name;
  late final String desc;
  late final ChatRoom chatRoom;
  late final String ownerId;
  late final List<dynamic> playlist;
  late final String image;

  Data.fromJson(Map<String, dynamic> json) {
    subscribes = List.castFrom<dynamic, dynamic>(json['subscribes']);
    unsubscribes = List.castFrom<dynamic, dynamic>(json['unsubscribes']);
    musicPreference = List.castFrom<dynamic, String>(json['musicPreference']);
    invitedUsers = List.castFrom<dynamic, dynamic>(json['invitedUsers']);
    trackUrl = null;
    visibility = json['visibility'];
    id = json['_id'];
    name = json['name'];
    desc = json['desc'];
    chatRoom = ChatRoom.fromJson(json['chatRoom']);
    ownerId = json['ownerId'];
    playlist = List.castFrom<dynamic, dynamic>(json['playlist']);
    image = json['image'] ??
        'https://i.picsum.photos/id/629/536/354.jpg?hmac=NWta_CV-ruzeQyb9CvcPbGAmrmMV66H8m9A2d_8rdpI';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['subscribes'] = subscribes;
    _data['unsubscribes'] = unsubscribes;
    _data['musicPreference'] = musicPreference;
    _data['invitedUsers'] = invitedUsers;
    _data['trackUrl'] = trackUrl;
    _data['visibility'] = visibility;
    _data['id'] = id;
    _data['name'] = name;
    _data['desc'] = desc;
    _data['chatRoom'] = chatRoom.toJson();
    _data['ownerId'] = ownerId;
    _data['playlist'] = playlist;
    _data['image'] = image;
    return _data;
  }
}

class ChatRoom {
  ChatRoom({
    required this.roomId,
  });
  late final String roomId;

  ChatRoom.fromJson(Map<String, dynamic> json) {
    roomId = json['roomId'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['roomId'] = roomId;
    return _data;
  }
}
