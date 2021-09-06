class PlaylistModel {
  List<String>? invitedUsers;
  List<String>? musicPreference;
  String? visibility;
  String? sId;
  String? name;
  String? desc;
  String? ownerId;
  List<Tracks>? tracks;

  PlaylistModel(
      {this.invitedUsers,
      this.musicPreference,
      this.visibility,
      this.sId,
      this.name,
      this.desc,
      this.ownerId,
      this.tracks});

  PlaylistModel.fromJson(Map<String, dynamic> json) {
    invitedUsers = json['invitedUsers'].cast<String>();
    musicPreference = json['musicPreference'].cast<String>();
    visibility = json['visibility'];
    sId = json['_id'];
    name = json['name'];
    desc = json['desc'];
    ownerId = json['ownerId'];
    if (json['tracks'] != null) {
      tracks = [];
      json['tracks'].forEach((v) {
        tracks!.add(new Tracks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['invitedUsers'] = this.invitedUsers;
    data['musicPreference'] = this.musicPreference;
    data['visibility'] = this.visibility;
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['desc'] = this.desc;
    data['ownerId'] = this.ownerId;
    if (this.tracks != null) {
      data['tracks'] = this.tracks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Tracks {
  List<Artists>? artists;
  List<Images>? images;
  String? sId;
  String? trackId;
  String? name;
  String? previewUrl;

  Tracks(
      {this.artists,
      this.images,
      this.sId,
      this.trackId,
      this.name,
      this.previewUrl});

  Tracks.fromJson(Map<String, dynamic> json) {
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
    trackId = json['trackId'];
    name = json['name'];
    previewUrl = json['preview_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.artists != null) {
      data['artists'] = this.artists!.map((v) => v.toJson()).toList();
    }
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    data['_id'] = this.sId;
    data['trackId'] = this.trackId;
    data['name'] = this.name;
    data['preview_url'] = this.previewUrl;
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

  Artists(
      {this.externalUrls, this.href, this.id, this.name, this.type, this.uri});

  Artists.fromJson(Map<String, dynamic> json) {
    externalUrls = json['external_urls'] != null
        ? new ExternalUrls.fromJson(json['external_urls'])
        : null;
    href = json['href'];
    id = json['id'];
    name = json['name'];
    type = json['type'];
    uri = json['uri'];
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
