class AlbumModel {
  List<String>? subscribes;
  List<String>? unsubscribes;
  List<String>? musicPreference;
  List<String>? invitedUsers;
  String? trackUrl;
  String? visibility;
  String? sId;
  String? name;
  String? desc;
  ChatRoom? chatRoom;
  String? ownerId;
  List<Playlist>? playlist;

  AlbumModel(
      {this.subscribes,
      this.unsubscribes,
      this.musicPreference,
      this.invitedUsers,
      this.trackUrl,
      this.visibility,
      this.sId,
      this.name,
      this.desc,
      this.chatRoom,
      this.ownerId,
      this.playlist});

  AlbumModel.fromJson(Map<String, dynamic> json) {
    subscribes = json['subscribes'].cast<String>();
    unsubscribes = json['unsubscribes'].cast<String>();
    musicPreference = json['musicPreference'].cast<String>();
    invitedUsers = json['invitedUsers'].cast<String>();
    trackUrl = json['trackUrl'];
    visibility = json['visibility'];
    sId = json['_id'];
    name = json['name'];
    desc = json['desc'];
    chatRoom = json['chatRoom'] != null
        ? new ChatRoom.fromJson(json['chatRoom'])
        : null;
    ownerId = json['ownerId'];
    if (json['playlist'] != null) {
      playlist = [];
      json['playlist'].forEach((v) {
        playlist!.add(new Playlist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subscribes'] = this.subscribes;
    data['unsubscribes'] = this.unsubscribes;
    data['musicPreference'] = this.musicPreference;
    data['invitedUsers'] = this.invitedUsers;
    data['trackUrl'] = this.trackUrl;
    data['visibility'] = this.visibility;
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['desc'] = this.desc;
    if (this.chatRoom != null) {
      data['chatRoom'] = this.chatRoom!.toJson();
    }
    data['ownerId'] = this.ownerId;
    if (this.playlist != null) {
      data['playlist'] = this.playlist!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChatRoom {
  String? roomId;
  List<Messages>? messages;

  ChatRoom({this.roomId, this.messages});

  ChatRoom.fromJson(Map<String, dynamic> json) {
    roomId = json['roomId'];
    if (json['messages'] != null) {
      messages = [];
      json['messages'].forEach((v) {
        messages!.add(new Messages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['roomId'] = this.roomId;
    if (this.messages != null) {
      data['messages'] = this.messages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Messages {
  String? message;
  String? name;

  Messages({this.message, this.name});

  Messages.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['name'] = this.name;
    return data;
  }
}

class Playlist {
  int? vote;
  List<Artists>? artists;
  List<Images>? images;
  String? sId;
  String? previewUrl;
  String? name;
  String? trackId;
  int? popularity;
  String? file;

  Playlist(
      {this.vote,
      this.artists,
      this.images,
      this.sId,
      this.previewUrl,
      this.name,
      this.trackId,
      this.popularity,
      this.file});

  Playlist.fromJson(Map<String, dynamic> json) {
    vote = json['vote'];
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
    sId = json['_id'];
    previewUrl = json['preview_url'];
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
    data['_id'] = this.sId;
    data['preview_url'] = this.previewUrl;
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
