import 'dart:convert';

ProfileModel profileModelFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str));

class ProfileModel {
  ProfileModel({
    this.className,
    this.objectId,
    this.createdAt,
    this.updatedAt,
    this.username,
    this.emailVerified,
    this.email,
    this.nama,
    this.telepon,
    this.tatar,
    this.sessionToken,
    this.issecurity,
    this.devicetoken,
  });

  String? className;
  String? objectId;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? username;
  bool? emailVerified;
  String? email;
  String? nama;
  String? telepon;
  String? tatar;
  String? sessionToken;
  bool? issecurity;
  String? devicetoken;

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        className: json["className"],
        objectId: json["objectId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        username: json["username"],
        emailVerified: json["emailVerified"],
        email: json["email"],
        nama: json["nama"],
        telepon: json["telepon"],
        tatar: json["tatar"],
        sessionToken: json["sessionToken"],
        issecurity: json["issecurity"],
        devicetoken: json["devicetoken"],
      );
}
