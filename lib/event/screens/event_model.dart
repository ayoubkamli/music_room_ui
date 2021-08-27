// To parse this JSON data, do
//
//     final songModel = songModelFromJson(jsonString);

import 'dart:convert';

SongModel songModelFromJson(String str) => SongModel.fromJson(json.decode(str));

String songModelToJson(SongModel data) => json.encode(data.toJson());

class SongModel {
  SongModel({
    this.id,
    this.subscribes,
    this.unsubscribes,
    this.musicPreference,
    this.trackUrl,
    this.visibility,
    this.name,
    this.desc,
    this.chatRoom,
    this.ownerId,
    this.playlist,
    this.v,
    this.invitedUsers,
    this.img,
  });

  Id? id;
  List<Id>? subscribes;
  List<dynamic>? unsubscribes;
  List<String>? musicPreference;
  String? trackUrl;
  String? visibility;
  String? name;
  String? desc;
  ChatRoom? chatRoom;
  Id? ownerId;
  List<Playlist>? playlist;
  int? v;
  List<Id>? invitedUsers;
  String? img;

  factory SongModel.fromJson(Map<String, dynamic> json) => SongModel(
        id: Id.fromJson(json["_id"]),
        subscribes:
            List<Id>.from(json["subscribes"].map((x) => Id.fromJson(x))),
        unsubscribes: List<dynamic>.from(json["unsubscribes"].map((x) => x)),
        musicPreference:
            List<String>.from(json["musicPreference"].map((x) => x)),
        trackUrl: json["trackUrl"],
        visibility: json["visibility"],
        name: json["name"],
        desc: json["desc"],
        chatRoom: ChatRoom.fromJson(json["chatRoom"]),
        ownerId: Id.fromJson(json["ownerId"]),
        playlist: List<Playlist>.from(
            json["playlist"].map((x) => Playlist.fromJson(x))),
        v: json["__v"],
        invitedUsers:
            List<Id>.from(json["invitedUsers"].map((x) => Id.fromJson(x))),
        img: json["img"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id!.toJson(),
        "subscribes": List<dynamic>.from(subscribes!.map((x) => x.toJson())),
        "unsubscribes": List<dynamic>.from(unsubscribes!.map((x) => x)),
        "musicPreference": List<dynamic>.from(musicPreference!.map((x) => x)),
        "trackUrl": trackUrl,
        "visibility": visibility,
        "name": name,
        "desc": desc,
        "chatRoom": chatRoom!.toJson(),
        "ownerId": ownerId!.toJson(),
        "playlist": List<dynamic>.from(playlist!.map((x) => x.toJson())),
        "__v": v,
        "invitedUsers":
            List<dynamic>.from(invitedUsers!.map((x) => x.toJson())),
        "img": img,
      };
}

class ChatRoom {
  ChatRoom({
    this.roomId,
    this.messages,
  });

  Id? roomId;
  List<Message>? messages;

  factory ChatRoom.fromJson(Map<String, dynamic> json) => ChatRoom(
        roomId: Id.fromJson(json["roomId"]),
        messages: List<Message>.from(
            json["messages"].map((x) => Message.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "roomId": roomId!.toJson(),
        "messages": List<dynamic>.from(messages!.map((x) => x.toJson())),
      };
}

class Message {
  Message({
    this.message,
    this.name,
  });

  String? message;
  String? name;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        message: json["message"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "name": name,
      };
}

class Id {
  Id({
    this.oid,
  });

  String? oid;

  factory Id.fromJson(Map<String, dynamic> json) => Id(
        oid: json["\u0024oid"],
      );

  Map<String, dynamic> toJson() => {
        "\u0024oid": oid,
      };
}

class Playlist {
  Playlist({
    this.artists,
    this.images,
    this.vote,
    this.id,
    this.previewUrl,
    this.name,
    this.trackId,
    this.popularity,
    this.file,
  });

  List<Artist>? artists;
  List<Image>? images;
  int? vote;
  Id? id;
  String? previewUrl;
  String? name;
  String? trackId;
  int? popularity;
  String? file;

  factory Playlist.fromJson(Map<String, dynamic> json) => Playlist(
        artists:
            List<Artist>.from(json["artists"].map((x) => Artist.fromJson(x))),
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
        vote: json["vote"],
        id: Id.fromJson(json["_id"]),
        previewUrl: json["preview_url"],
        name: json["name"],
        trackId: json["trackId"],
        popularity: json["popularity"],
        file: json["file"],
      );

  Map<String, dynamic> toJson() => {
        "artists": List<dynamic>.from(artists!.map((x) => x.toJson())),
        "images": List<dynamic>.from(images!.map((x) => x.toJson())),
        "vote": vote,
        "_id": id!.toJson(),
        "preview_url": previewUrl,
        "name": name,
        "trackId": trackId,
        "popularity": popularity,
        "file": file,
      };
}

class Artist {
  Artist({
    this.externalUrls,
    this.href,
    this.id,
    this.name,
    this.type,
    this.uri,
  });

  ExternalUrls? externalUrls;
  String? href;
  String? id;
  String? name;
  String? type;
  String? uri;

  factory Artist.fromJson(Map<String, dynamic> json) => Artist(
        externalUrls: ExternalUrls.fromJson(json["external_urls"]),
        href: json["href"],
        id: json["id"],
        name: json["name"],
        type: json["type"],
        uri: json["uri"],
      );

  Map<String, dynamic> toJson() => {
        "external_urls": externalUrls!.toJson(),
        "href": href,
        "id": id,
        "name": name,
        "type": type,
        "uri": uri,
      };
}

class ExternalUrls {
  ExternalUrls({
    this.spotify,
  });

  String? spotify;

  factory ExternalUrls.fromJson(Map<String, dynamic> json) => ExternalUrls(
        spotify: json["spotify"],
      );

  Map<String, dynamic> toJson() => {
        "spotify": spotify,
      };
}

class Image {
  Image({
    this.height,
    this.url,
    this.width,
  });

  int? height;
  String? url;
  int? width;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        height: json["height"],
        url: json["url"],
        width: json["width"],
      );

  Map<String, dynamic> toJson() => {
        "height": height,
        "url": url,
        "width": width,
      };
}
