
class User {
/*
{
  "musicPreference": [
    "ddd"
  ],
  "status": "online",
  "visibility": "Public",
  "isVerified": true,
  "_id": "dddd",
  "email": "ssss",
  "password": "2a$10$Po2CuQhqp8kLjvGfEuMRkejR8vhsxEd/6097mC9Samy5iavr7ApO2",
  "token": "dddd",
  "picture": "ddd"
} 
*/

  List<String>? musicPreference;
  String? status;
  String? visibility;
  bool? isVerified;
  String? id;
  String? email;
  String? password;
  String? token;
  String? picture;
  String? username;

  User({
    this.musicPreference,
    this.status,
    this.visibility,
    this.isVerified,
    this.id,
    this.username,
    this.email,
    this.password,
    this.token,
    this.picture,
  });
  User.fromJson(Map<String, dynamic> json) {
    if (json["musicPreference"] != null) {
      final v = json["musicPreference"];
      final arr0 = <String>[];
      v.forEach((v) {
        arr0.add(v.toString());
      });
      musicPreference = arr0;
    }
    status = json["status"]?.toString();
    visibility = json["visibility"]?.toString();
    username = json["username"]?.toString();
    isVerified = json["isVerified"];
    id = json["_id"]?.toString();
    email = json["email"]?.toString();
    password = json["password"]?.toString();
    token = json["token"]?.toString();
    picture = json["picture"]?.toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (musicPreference != null) {
      final v = musicPreference;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v);
      });
      data["musicPreference"] = arr0;
    }
    data["status"] = status;
    data["visibility"] = visibility;
    data["usernmae"] = username;
    data["isVerified"] = isVerified;
    data["_id"] = id;
    data["email"] = email;
    data["password"] = password;
    data["token"] = token;
    data["picture"] = picture;
    return data;
  }
}

class UserData {
/*
{
  "success": true,
  "data": {
    "musicPreference": [
      "ddd"
    ],
    "status": "online",
    "visibility": "Public",
    "isVerified": true,
    "_id": "dddd",
    "email": "ssss",
    "password": "2a$10$Po2CuQhqp8kLjvGfEuMRkejR8vhsxEd/6097mC9Samy5iavr7ApO2",
    "token": "dddd",
    "picture": "ddd"
  }
} 
*/

  bool? success;
  User? data;

  UserData({
    this.success,
    this.data,
  });
  UserData.fromJson(Map<String, dynamic> json) {
    success = json["success"];
    data = (json["data"] != null) ? User.fromJson(json["data"]) : null;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["success"] = success;

    data["data"] = this.data!.toJson();

    return data;
  }
}
