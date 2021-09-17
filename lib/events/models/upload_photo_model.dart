class UploadPhotoModel {
  bool? success;
  Data? data;

  UploadPhotoModel({this.success, this.data});

  UploadPhotoModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
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
  List<String>? playlist;
  int? iV;

  Data(
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
      this.playlist,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
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
    playlist = json['playlist'].cast<String>();
    iV = json['__v'];
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
    data['playlist'] = this.playlist;
    data['__v'] = this.iV;
    return data;
  }
}

class ChatRoom {
  String? roomId;

  ChatRoom({this.roomId});

  ChatRoom.fromJson(Map<String, dynamic> json) {
    roomId = json['roomId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['roomId'] = this.roomId;
    return data;
  }
}
