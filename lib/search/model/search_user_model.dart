///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class UserModel {
/*
{
  "musicPreference": [
    "HIP HOP"
  ],
  "status": "online",
  "visibility": "Public",
  "isVerified": true,
  "_id": "61649989c1165400210a6548",
  "email": "user001@gmail.com",
  "username": "test001",
  "picture": "http://$ip/api/media/file-1637946929309.jpeg"
} 
*/

  List<String?>? musicPreference;
  String? status;
  String? visibility;
  bool? isVerified;
  String? id;
  String? email;
  String? username;
  String? picture;

  UserModel({
    this.musicPreference,
    this.status,
    this.visibility,
    this.isVerified,
    this.id,
    this.email,
    this.username,
    this.picture,
  });
  UserModel.fromJson(Map<String, dynamic> json) {
    if (json['musicPreference'] != null) {
      final v = json['musicPreference'];
      final arr0 = <String>[];
      v.forEach((v) {
        arr0.add(v.toString());
      });
      musicPreference = arr0;
    }
    status = json['status']?.toString();
    visibility = json['visibility']?.toString();
    isVerified = json['isVerified'];
    id = json['_id']?.toString();
    email = json['email']?.toString();
    username = json['username']?.toString();
    picture = json['picture']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (musicPreference != null) {
      final v = musicPreference;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v);
      });
      data['musicPreference'] = arr0;
    }
    data['status'] = status;
    data['visibility'] = visibility;
    data['isVerified'] = isVerified;
    data['_id'] = id;
    data['email'] = email;
    data['username'] = username;
    data['picture'] = picture;
    return data;
  }
}