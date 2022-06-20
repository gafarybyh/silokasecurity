// To parse this JSON data, do
//
//     final visitorModel = visitorModelFromJson(jsonString);

import 'dart:convert';

VisitorModel visitorModelFromJson(String str) =>
    VisitorModel.fromJson(json.decode(str));

String visitorModelToJson(VisitorModel data) => json.encode(data.toJson());

class VisitorModel {
  VisitorModel({
    this.className,
    this.objectId,
    this.createdAt,
    this.updatedAt,
    this.pesan,
    this.alamat,
    this.tatar,
    this.pengirim,
    this.done,
  });

  String? className;
  String? objectId;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? pesan;
  String? alamat;
  String? tatar;
  String? pengirim;
  bool? done;

  factory VisitorModel.fromJson(Map<String, dynamic> json) => VisitorModel(
        className: json["className"],
        objectId: json["objectId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        pesan: json["pesan"],
        alamat: json["alamat"],
        tatar: json["tatar"],
        pengirim: json["pengirim"],
        done: json["done"],
      );

  Map<String, dynamic> toJson() => {
        "className": className,
        "objectId": objectId,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "pesan": pesan,
        "alamat": alamat,
        "tatar": tatar,
        "pengirim": pengirim,
        "done": done,
      };
}
