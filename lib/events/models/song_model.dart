class AlbumModel {
  AlbumModel({
    required this.success,
    required this.data,
  });
  late final bool success;
  late final AlbumData data;

  AlbumModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = AlbumData.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['data'] = data.toJson();
    return _data;
  }
}

class AlbumData {
  AlbumData({
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
  late final List<dynamic>? subscribes;
  late final List<dynamic>? unsubscribes;
  late final List<String> musicPreference;
  late final List<dynamic>? invitedUsers;
  late final Null trackUrl;
  late final String visibility;
  late final String id;
  late final String name;
  late final String desc;
  late final ChatRoom chatRoom;
  late final String ownerId;
  late final List<PlaylistData> playlist;
  late final String image;

  AlbumData.fromJson(Map<String, dynamic> json) {
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
    if (json['playlist'] != null) {
      playlist = [];
      json['playlist'].forEach((v) {
        playlist.add(new PlaylistData.fromJson(v));
      });
    }
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

class PlaylistData {
  int? vote;
  List<Artists>? artists;
  List<Images>? images;
  String? id;
  String? previewUrl;
  String? name;
  String? trackId;
  int? popularity;
  String? file;
  String? image;

  PlaylistData(
      {this.vote,
      this.artists,
      this.images,
      this.id,
      this.previewUrl,
      this.name,
      this.trackId,
      this.popularity,
      this.file,
      this.image});

  PlaylistData.fromJson(Map<String, dynamic> json) {
    // vote = json['vote'];
    if (json['artists'] != null) {
      artists = [];
      json['artists'].forEach((v) {
        artists!.add(new Artists.fromJson(v));
      });
    }
    if (json['images'] != null) {
      images = [];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
    id = json['_id'];
    previewUrl = json['preview_url'];
    image = json['image'];
    name = json['name'];
    trackId = json['trackId'];
    popularity = json['popularity'];
    file = json['file'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vote'] = this.vote;
    if (this.artists != null) {
      data['artists'] = this.artists!.map((v) => v.toJson()).toList();
    }
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    data['_id'] = this.id;
    data['preview_url'] = this.previewUrl;
    data['image'] = this.image;
    data['name'] = this.name;
    data['trackId'] = this.trackId;
    data['popularity'] = this.popularity;
    data['file'] = this.file;
    return data;
  }
}

class Artists {
  ExternalUrls? externalUrls;
  String? href;
  String? id;
  String? name;
  String? type;
  String? uri;
  int? iV;

  Artists(
      {this.externalUrls,
      this.href,
      this.id,
      this.name,
      this.type,
      this.uri,
      this.iV});

  Artists.fromJson(Map<String, dynamic> json) {
    externalUrls = json['external_urls'] != null
        ? new ExternalUrls.fromJson(json['external_urls'])
        : null;
    href = json['href'];
    id = json['id'];
    name = json['name'];
    type = json['type'];
    uri = json['uri'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.externalUrls != null) {
      data['external_urls'] = this.externalUrls!.toJson();
    }
    data['href'] = this.href;
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    data['uri'] = this.uri;
    data['__v'] = this.iV;
    return data;
  }
}

class ExternalUrls {
  String? spotify;

  ExternalUrls({this.spotify});

  ExternalUrls.fromJson(Map<String, dynamic> json) {
    spotify = json['spotify'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['spotify'] = this.spotify;
    return data;
  }
}

class Images {
  int? height;
  String? url;
  int? width;

  Images({this.height, this.url, this.width});

  Images.fromJson(Map<String, dynamic> json) {
    height = json['height'];
    url = json['url'];
    width = json['width'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['height'] = this.height;
    data['url'] = this.url;
    data['width'] = this.width;
    return data;
  }
}
