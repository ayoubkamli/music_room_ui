class Pmodel {
  Pmodel({
    required this.success,
    required this.data,
  });
  late final bool success;
  late final PData data;

  Pmodel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = PData.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['data'] = data.toJson();
    return _data;
  }
}

class PData {
  PData({
    required this.invitedUsers,
    required this.musicPreference,
    required this.visibility,
    required this.id,
    required this.name,
    required this.desc,
    required this.ownerId,
    required this.tracks,
    required this.V,
    required this.image,
  });
  late final List<String> invitedUsers;
  late final List<String> musicPreference;
  late final String visibility;
  late final String id;
  late final String name;
  late final String desc;
  late final String ownerId;
  late final List<Tracks> tracks;
  late final int V;
  late final String? image;

  PData.fromJson(Map<String, dynamic> json) {
    invitedUsers = List.castFrom<dynamic, String>(json['invitedUsers']);
    musicPreference = List.castFrom<dynamic, String>(json['musicPreference']);
    visibility = json['visibility'];
    id = json['_id'];
    name = json['name'];
    desc = json['desc'];
    ownerId = json['ownerId'];
    tracks = List.from(json['tracks']).map((e) => Tracks.fromJson(e)).toList();
    V = json['__v'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['invitedUsers'] = invitedUsers;
    _data['musicPreference'] = musicPreference;
    _data['visibility'] = visibility;
    _data['_id'] = id;
    _data['name'] = name;
    _data['desc'] = desc;
    _data['ownerId'] = ownerId;
    _data['tracks'] = tracks.map((e) => e.toJson()).toList();
    _data['__v'] = V;
    _data['image'] = image;
    return _data;
  }
}

class Tracks {
  Tracks({
    required this.artists,
    required this.images,
    required this.id,
    required this.trackId,
    required this.name,
    required this.previewUrl,
    required this.popularity,
  });
  late final List<Artists> artists;
  late final List<Images> images;
  late final String id;
  late final String trackId;
  late final String name;
  late final String previewUrl;
  late final int popularity;

  Tracks.fromJson(Map<String, dynamic> json) {
    artists =
        List.from(json['artists']).map((e) => Artists.fromJson(e)).toList();
    images = List.from(json['images']).map((e) => Images.fromJson(e)).toList();
    id = json['_id'];
    trackId = json['trackId'];
    name = json['name'];
    previewUrl = json['preview_url'];
    popularity = json['popularity'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['artists'] = artists.map((e) => e.toJson()).toList();
    _data['images'] = images.map((e) => e.toJson()).toList();
    _data['_id'] = id;
    _data['trackId'] = trackId;
    _data['name'] = name;
    _data['preview_url'] = previewUrl;
    _data['popularity'] = popularity;
    return _data;
  }
}

class Artists {
  Artists({
    required this.externalUrls,
    required this.href,
    required this.id,
    required this.name,
    required this.type,
    required this.uri,
  });
  late final ExternalUrls externalUrls;
  late final String href;
  late final String id;
  late final String name;
  late final String type;
  late final String uri;

  Artists.fromJson(Map<String, dynamic> json) {
    externalUrls = ExternalUrls.fromJson(json['external_urls']);
    href = json['href'];
    id = json['id'];
    name = json['name'];
    type = json['type'];
    uri = json['uri'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['external_urls'] = externalUrls.toJson();
    _data['href'] = href;
    _data['id'] = id;
    _data['name'] = name;
    _data['type'] = type;
    _data['uri'] = uri;
    return _data;
  }
}

class ExternalUrls {
  ExternalUrls({
    required this.spotify,
  });
  late final String spotify;

  ExternalUrls.fromJson(Map<String, dynamic> json) {
    spotify = json['spotify'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['spotify'] = spotify;
    return _data;
  }
}

class Images {
  Images({
    required this.height,
    required this.url,
    required this.width,
  });
  late final int height;
  late final String url;
  late final int width;

  Images.fromJson(Map<String, dynamic> json) {
    height = json['height'];
    url = json['url'];
    width = json['width'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['height'] = height;
    _data['url'] = url;
    _data['width'] = width;
    return _data;
  }
}
