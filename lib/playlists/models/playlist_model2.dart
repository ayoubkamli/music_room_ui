class PlaylistModel {
  bool? success;
  List<PlaylistData>? data;

  PlaylistModel({
    this.success,
    this.data,
  });

  PlaylistModel.fromJson(Map<String, dynamic> json) {
    success = json['success'] as bool?;
    data = (json['data'] as List?)
        ?.map((dynamic e) => PlaylistData.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['success'] = success;
    json['data'] = data?.map((e) => e.toJson()).toList();
    return json;
  }
}

class PlaylistData {
  List<String>? invitedUsers;
  List<String>? musicPreference;
  String? visibility;
  String? id;
  String? name;
  String? desc;
  String? ownerId;
  List<Tracks>? tracks;
  int? v;
  String? image;

  PlaylistData({
    this.invitedUsers,
    this.musicPreference,
    this.visibility,
    this.id,
    this.name,
    this.desc,
    this.ownerId,
    this.tracks,
    this.v,
    this.image,
  });

  PlaylistData.fromJson(Map<String, dynamic> json) {
    invitedUsers = (json['invitedUsers'] as List?)
        ?.map((dynamic e) => e as String)
        .toList();
    musicPreference = (json['musicPreference'] as List?)
        ?.map((dynamic e) => e as String)
        .toList();
    visibility = json['visibility'] as String?;
    id = json['_id'] as String?;
    name = json['name'] as String?;
    desc = json['desc'] as String?;
    ownerId = json['ownerId'] as String?;
    tracks = (json['tracks'] as List?)
        ?.map((dynamic e) => Tracks.fromJson(e as Map<String, dynamic>))
        .toList();
    v = json['__v'] as int?;
    image = json['image'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['invitedUsers'] = invitedUsers;
    json['musicPreference'] = musicPreference;
    json['visibility'] = visibility;
    json['_id'] = id;
    json['name'] = name;
    json['desc'] = desc;
    json['ownerId'] = ownerId;
    json['tracks'] = tracks?.map((e) => e.toJson()).toList();
    json['__v'] = v;
    json['image'] = image;
    return json;
  }
}

class Tracks {
  List<Artists>? artists;
  List<Images>? images;
  String? id;
  String? trackId;
  String? name;
  String? previewUrl;
  int? popularity;

  Tracks({
    this.artists,
    this.images,
    this.id,
    this.trackId,
    this.name,
    this.previewUrl,
    this.popularity,
  });

  Tracks.fromJson(Map<String, dynamic> json) {
    artists = (json['artists'] as List?)
        ?.map((dynamic e) => Artists.fromJson(e as Map<String, dynamic>))
        .toList();
    images = (json['images'] as List?)
        ?.map((dynamic e) => Images.fromJson(e as Map<String, dynamic>))
        .toList();
    id = json['_id'] as String?;
    trackId = json['trackId'] as String?;
    name = json['name'] as String?;
    previewUrl = json['preview_url'] as String?;
    popularity = json['popularity'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['artists'] = artists?.map((e) => e.toJson()).toList();
    json['images'] = images?.map((e) => e.toJson()).toList();
    json['_id'] = id;
    json['trackId'] = trackId;
    json['name'] = name;
    json['preview_url'] = previewUrl;
    json['popularity'] = popularity;
    return json;
  }
}

class Artists {
  ExternalUrls? externalUrls;
  String? href;
  String? id;
  String? name;
  String? type;
  String? uri;

  Artists({
    this.externalUrls,
    this.href,
    this.id,
    this.name,
    this.type,
    this.uri,
  });

  Artists.fromJson(Map<String, dynamic> json) {
    externalUrls = (json['external_urls'] as Map<String, dynamic>?) != null
        ? ExternalUrls.fromJson(json['external_urls'] as Map<String, dynamic>)
        : null;
    href = json['href'] as String?;
    id = json['id'] as String?;
    name = json['name'] as String?;
    type = json['type'] as String?;
    uri = json['uri'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['external_urls'] = externalUrls?.toJson();
    json['href'] = href;
    json['id'] = id;
    json['name'] = name;
    json['type'] = type;
    json['uri'] = uri;
    return json;
  }
}

class ExternalUrls {
  String? spotify;

  ExternalUrls({
    this.spotify,
  });

  ExternalUrls.fromJson(Map<String, dynamic> json) {
    spotify = json['spotify'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['spotify'] = spotify;
    return json;
  }
}

class Images {
  int? height;
  String? url;
  int? width;

  Images({
    this.height,
    this.url,
    this.width,
  });

  Images.fromJson(Map<String, dynamic> json) {
    height = json['height'] as int?;
    url = json['url'] as String?;
    width = json['width'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['height'] = height;
    json['url'] = url;
    json['width'] = width;
    return json;
  }
}
