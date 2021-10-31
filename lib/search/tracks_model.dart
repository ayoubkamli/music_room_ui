class TracksModel {
  TracksModel({
    required this.success,
    required this.data,
  });
  late final bool success;
  late final List<Data> data;

  TracksModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['data'] = data.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Data {
  Data({
    required this.artists,
    required this.previewUrl,
    required this.name,
    required this.images,
    required this.trakId,
    required this.popularity,
  });
  late final List<Artists> artists;
  late final String previewUrl;
  late final String name;
  late final List<Images> images;
  late final String trakId;
  late final int popularity;

  Data.fromJson(Map<String, dynamic> json) {
    artists =
        List.from(json['artists']).map((e) => Artists.fromJson(e)).toList();
    previewUrl = json['preview_url'];
    name = json['name'];
    images = List.from(json['images']).map((e) => Images.fromJson(e)).toList();
    trakId = json['trakId'];
    popularity = json['popularity'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['artists'] = artists.map((e) => e.toJson()).toList();
    _data['preview_url'] = previewUrl;
    _data['name'] = name;
    _data['images'] = images.map((e) => e.toJson()).toList();
    _data['trakId'] = trakId;
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
